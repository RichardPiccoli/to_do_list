class ItemsController < ApplicationController
  before_action :set_list, except: [ :move ]
  before_action :set_item, only: [ :update, :destroy ]

  # POST /lists/:list_id/items - criação com Turbo Stream
  def create
    @item = @list.items.new(item_params)

    if @item.save
      flash.now[:success] = "Item criado com sucesso."

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to list_path(@list) }
      end
    else
      flash.now[:error] = "Erro ao criar item."

      respond_to do |format|
        format.turbo_stream { render :error, status: :unprocessable_entity }
        format.html { render "lists/show", status: :unprocessable_entity }
      end
    end
  end

  # Atualização (checkbox de concluído)
  def update
    if @item.update(item_params)
      flash.now[:success] = "Item atualizado."

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to list_path(@list) }
      end
    else
      flash.now[:error] = "Erro ao atualizar item."

      respond_to do |format|
        format.turbo_stream { render :error, status: :unprocessable_entity }
        format.html { redirect_to list_path(@list), error: "Erro ao atualizar item." }
      end
    end
  end

  # Remoção
  def destroy
    @item.destroy
    flash.now[:success] = "Item removido."

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to list_path(@list), success: "Item removido com sucesso." }
    end
  end

  # PATCH /lists/:list_id/items/reorder - reordena itens dentro da lista do usuário
  def reorder
    list = current_user.lists.find(params[:list_id])
    item_ids = params[:item_ids] || []

    item_ids.each_with_index do |id, index|
      list.items.find(id).update(position: index)
    end

    head :ok
  end

  # PATCH /items/:id/move - move item para outra lista do usuário (rota top-level)
  def move
    @item = current_user.items.find(params[:id])
    new_list = current_user.lists.find(params[:list_id])
    new_position = [ params[:position].to_i, 0 ].max

    @item.update(list_id: new_list.id, position: new_position)

    new_list.items.order(:position).each_with_index do |item, idx|
      item.update(position: idx) unless item.position == idx
    end

    head :ok
  end

  private

  # Carrega a lista pelo list_id, somente entre as listas do usuário logado
  def set_list
    @list = current_user.lists.find(params[:list_id])
  end

  # Carrega o item pelo id dentro da lista; trata RecordNotFound com redirect ou Turbo Stream
  def set_item
    @item = @list.items.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { redirect_to list_path(@list), error: "Item não encontrado." }
      format.turbo_stream do
        flash.now[:error] = "Item não encontrado."
        render turbo_stream: turbo_stream.replace("flash_messages", partial: "shared/flash")
      end
    end
  end

  # Strong parameters para item
  def item_params
    params.require(:item).permit(:title, :notes, :done, :due_date, :position)
  end
end

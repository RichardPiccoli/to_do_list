class ItemsController < ApplicationController
  before_action :set_list
  before_action :set_item, only: [ :update, :destroy ]

  # Criação com Turbo
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

  # app/controllers/items_controller.rb
  def reorder
    # Este método é chamado com o list_id e um array de item_ids
    list = List.find(params[:list_id])
    item_ids = params[:item_ids]

    item_ids.each_with_index do |id, index|
      list.items.find(id).update(position: index)
    end

    head :ok
  end

  # app/controllers/items_controller.rb
  def move
    @item = Item.find(params[:id])
    new_list_id = params[:list_id]
    new_position = params[:position].to_i

    # Atualiza a lista e a posição
    @item.update(list_id: new_list_id, position: new_position)

    # Reordenar os itens da nova lista para garantir consistência
    list = List.find(new_list_id)
    list.items.order(:position).each_with_index do |item, idx|
      item.update(position: idx) unless item.position == idx
    end

    head :ok
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

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

  def item_params
    params.require(:item).permit(:title, :notes, :done, :due_date, :position)
  end
end

class ItemsController < ApplicationController
  before_action :set_list
  before_action :set_item, only: [:update, :destroy]

  # Criação com Turbo
  def create
    @item = @list.items.new(item_params)

    if @item.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to list_path(@list) }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Atualização (checkbox de concluído)
  def update
    if @item.update(item_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to list_path(@list) }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Remoção
  def destroy
    @item.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to list_path(@list) }
    end
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_item
    @item = @list.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:title, :notes, :done, :due_date, :position)
  end
end
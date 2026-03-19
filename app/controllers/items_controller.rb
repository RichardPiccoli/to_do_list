class ItemsController < ApplicationController
  # Executa antes de todas as ações
  before_action :set_list
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /lists/:list_id/items
  def index
    @items = @list.items

    respond_to do |format|
      format.html
      format.json { render json: @items, status: :ok }
    end
  end

  # GET /lists/:list_id/items/:id
  def show
    respond_to do |format|
      format.html
      format.json { render json: @item, status: :ok }
    end
  end

  # GET /lists/:list_id/items/new
  def new
    @item = @list.items.new
  end

  # POST /lists/:list_id/items
  def create
  @item = @list.items.new(item_params)

  if @item.save
    # Redireciona de volta para a lista
    redirect_to list_path(@list), notice: "Item criado."
  else
    render :new, status: :unprocessable_entity
  end
end

  # GET /lists/:list_id/items/:id/edit
  def edit
  end

  # PATCH/PUT /lists/:list_id/items/:id
  def update
    if @item.update(item_params)
      respond_to do |format|
        format.html { redirect_to list_path(@list), notice: "Item atualizado." }
        format.json { render json: @item, status: :ok }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/:list_id/items/:id
  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to list_path(@list), notice: "Item removido." }
      format.json { head :no_content }
    end
  end

  private

  # Busca a lista pelo ID
  def set_list
    @list = List.find(params[:list_id])
  rescue ActiveRecord::RecordNotFound
    render json: { erro: "Lista não encontrada" }, status: :not_found
  end

  # Busca o item pelo ID dentro da lista
  def set_item
    @item = @list.items.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { erro: "Item não encontrado" }, status: :not_found
  end

  # Strong parameters
  def item_params
    params.require(:item).permit(:title, :notes, :done, :due_date, :position)
  end
end
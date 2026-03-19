class ListsController < ApplicationController
  # Executa antes das ações que precisam de uma lista específica
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  # GET /lists
  def index
    # Busca todas as listas no banco
    @lists = List.all

    respond_to do |format|
      # Resposta HTML (views)
      format.html

      # Resposta JSON (API)
      format.json { render json: @lists, status: :ok }
    end
  end

  # GET /lists/:id
  def show
    respond_to do |format|
      format.html
      format.json do
        # Inclui os itens associados na resposta JSON
        render json: @list.as_json(include: :items), status: :ok
      end
    end
  end

  # GET /lists/new
  def new
    # Inicializa uma nova lista (para formulário)
    @list = List.new
  end

  # POST /lists
  def create
    # Cria lista com parâmetros permitidos
    @list = List.new(list_params)

    if @list.save
      respond_to do |format|
        format.html { redirect_to @list, notice: "Lista criada com sucesso." }
        format.json { render json: @list, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /lists/:id/edit
  def edit
  end

  # PATCH/PUT /lists/:id
  def update
    if @list.update(list_params)
      respond_to do |format|
        format.html { redirect_to @list, notice: "Lista atualizada com sucesso." }
        format.json { render json: @list, status: :ok }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/:id
  def destroy
    @list.destroy

    respond_to do |format|
      format.html { redirect_to lists_path, notice: "Lista removida." }
      format.json { head :no_content }
    end
  end

  private

  # Busca a lista pelo ID
  def set_list
    @list = List.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { erro: "Lista não encontrada" }, status: :not_found
  end

  # Strong parameters (segurança)
  def list_params
    params.require(:list).permit(:title, :description)
  end
end
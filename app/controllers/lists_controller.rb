class ListsController < ApplicationController
  # Executa antes das ações que precisam de uma lista específica
  before_action :set_list, only: [ :show, :edit, :update, :destroy ]

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
    # Garante que @items sempre exista (mesmo se vazio)
    @items = @list.items.ordenados

    # Garante item para o formulário
    @item = @list.items.new

    respond_to do |format|
      format.html
      format.json do
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
    @list = List.new(list_params)

    if @list.save
      flash.now[:success] = "Lista criada com sucesso."

      respond_to do |format|
        format.html { redirect_to @list, success: "Lista criada com sucesso." }
        format.turbo_stream
        format.json { render json: @list, status: :created }
      end
    else
      flash.now[:error] = "Erro ao criar lista."

      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render :error }
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
      flash.now[:success] = "Lista atualizada com sucesso."

      respond_to do |format|
        format.html { redirect_to @list, success: "Lista atualizada com sucesso." }
        format.turbo_stream
        format.json { render json: @list, status: :ok }
      end
    else
      flash.now[:error] = "Erro ao atualizar lista."

      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render :error }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end
  # DELETE /lists/:id
  def destroy
    @list.destroy
    flash.now[:success] = "Lista removida com sucesso."

    respond_to do |format|
      format.html { redirect_to lists_path, success: "Lista removida com sucesso." }
      format.turbo_stream
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

  # app/controllers/lists_controller.rb
  def reorder
    # Espera um array de IDs na ordem desejada
    list_ids = params[:list_ids]

    # Atualiza a posição de cada lista com base na ordem
    list_ids.each_with_index do |id, index|
      List.find(id).update(position: index)
    end

    head :ok  # Retorna apenas status 200 sem conteúdo
  end

  # Strong parameters (segurança)
  def list_params
    params.require(:list).permit(:title, :description)
  end
end

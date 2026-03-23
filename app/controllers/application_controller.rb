class ApplicationController < ActionController::Base
  # Exige autenticação em todas as ações; redireciona para login se o usuário não estiver logado
  before_action :authenticate_user!

  # Registra tipos customizados de flash para uso em Turbo Streams e redirects
  add_flash_types :success, :error, :warning
end

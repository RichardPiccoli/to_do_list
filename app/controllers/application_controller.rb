class ApplicationController < ActionController::Base
  # Registra tipos customizados de flash para uso em Turbo Streams e redirects
  add_flash_types :success, :error, :warning
end

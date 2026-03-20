class ApplicationController < ActionController::Base
  # Permite usar flash com Turbo Streams
  add_flash_types :success, :error, :warning
end
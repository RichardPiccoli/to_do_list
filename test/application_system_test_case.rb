require "test_helper"
require "capybara/rails"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  # Usa o driver padrão do Rails (rack_test) para testes rápidos.
  # Se quiser testar JavaScript, troque para :selenium (exige chromedriver).
  driven_by :rack_test

  include Warden::Test::Helpers

  setup do
    # Ativa o modo de teste do Warden para usar login_as
    Warden.test_mode!
  end

  teardown do
    # Limpa a sessão do Warden após cada teste
    Warden.test_reset!
  end
end

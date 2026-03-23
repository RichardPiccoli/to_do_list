require "test_helper"
require "capybara/rails"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Warden::Test::Helpers

  driven_by :rack_test

  setup do
    # Habilita modo de teste do Warden para uso de login_as nos testes
    Warden.test_mode!
  end

  teardown do
    # Limpa a sessão do Warden após cada teste
    Warden.test_reset!
  end
end

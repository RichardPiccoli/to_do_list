require "application_system_test_case"

class ListsTest < ApplicationSystemTestCase
  test "criar lista e item" do
    # Cria usuário para autenticação (Devise exige email e senha)
    usuario = User.create!(
      email: "teste@exemplo.com",
      password: "Senha@123456",
      password_confirmation: "Senha@123456"
    )

    # Simula login do usuário (Warden::Test::Helpers)
    login_as(usuario, scope: :user)

    # Acessa a página de listas (requer usuário autenticado)
    visit lists_path

    # O formulário de nova lista já está visível, então preenchemos diretamente
    # O campo de título tem placeholder "Nome da lista"
    fill_in "Nome da lista", with: "Lista E2E"

    # O botão de criar lista tem texto "Salvar"
    click_on "Salvar"

    # Verifica mensagem de sucesso (flash)
    assert_text "Lista criada com sucesso"

    # Após criar a lista, ela aparece no board. Agora preenchemos o formulário de item
    # O placeholder do campo de item é "Nova tarefa..."
    fill_in "Nova tarefa...", with: "Tarefa E2E"

    # O botão de adicionar item é "+"
    click_on "+"

    # Verifica se o item aparece na lista
    assert_text "Tarefa E2E"
  end
end

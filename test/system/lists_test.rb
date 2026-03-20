require "application_system_test_case"

class ListsTest < ApplicationSystemTestCase
  test "criar lista e item" do
    visit lists_path

    click_on "Nova Lista"

    fill_in "Título", with: "Lista E2E"
    click_on "Criar Lista"

    assert_text "Lista criada com sucesso"

    fill_in "Nova tarefa", with: "Tarefa E2E"
    click_on "Adicionar"

    assert_text "Tarefa E2E"
  end
end
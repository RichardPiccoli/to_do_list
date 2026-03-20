require "test_helper"

class ListsControllerTest < ActionDispatch::IntegrationTest
  test "deve listar listas" do
    get lists_url
    assert_response :success
  end

  test "deve criar lista válida" do
    assert_difference("List.count") do
      post lists_url, params: {
        list: { title: "Nova lista", description: "Desc" }
      }
    end

    assert_redirected_to list_path(List.last)
  end

  test "não deve criar lista inválida" do
    assert_no_difference("List.count") do
      post lists_url, params: {
        list: { title: "" }
      }
    end

    assert_response :unprocessable_entity
  end

  test "deve deletar lista" do
    list = List.create!(title: "Teste")

    assert_difference("List.count", -1) do
      delete list_url(list)
    end

    assert_redirected_to lists_path
  end
end

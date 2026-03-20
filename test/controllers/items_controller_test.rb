require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @list = List.create!(title: "Lista teste")
  end

  test "deve criar item válido" do
    assert_difference("Item.count") do
      post list_items_url(@list), params: {
        item: { title: "Novo item" }
      }, as: :turbo_stream
    end

    assert_response :success
  end

  test "não deve criar item inválido" do
    assert_no_difference("Item.count") do
      post list_items_url(@list), params: {
        item: { title: "" }
      }, as: :turbo_stream
    end

    assert_response :unprocessable_entity
  end

  test "deve atualizar item" do
    item = @list.items.create!(title: "Item")

    patch list_item_url(@list, item), params: {
      item: { done: true }
    }

    item.reload
    assert item.done
  end

  test "deve deletar item" do
    item = @list.items.create!(title: "Item")

    assert_difference("Item.count", -1) do
      delete list_item_url(@list, item)
    end
  end
end

require "test_helper"

class ItemTest < ActiveSupport::TestCase
  def setup
    @list = List.create!(title: "Lista base")
  end

  test "deve ser válido com dados corretos" do
    item = @list.items.new(title: "Tarefa 1")
    assert item.valid?
  end

  test "não deve salvar sem título" do
    item = @list.items.new(title: nil)
    assert_not item.valid?
    assert_includes item.errors[:title], "não pode ficar vazio"
  end

  test "não deve aceitar título curto" do
    item = Item.new(title: "ab")
    assert_not item.valid?
    assert_includes item.errors[:title], "deve ter entre 3 e 100 caracteres"
  end

  test "notes não deve ultrapassar 300 caracteres" do
    item = @list.items.new(
      title: "Tarefa válida",
      notes: "a" * 301
    )

    assert_not item.valid?
    assert_includes item.errors[:notes], "muito longa (máximo 300 caracteres)"
  end

  test "deve pertencer a uma lista" do
    item = Item.new(title: "Sem lista")
    assert_not item.valid?
  end
end

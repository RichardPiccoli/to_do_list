require "test_helper"

class ListTest < ActiveSupport::TestCase
  test "deve ser válida com título válido" do
    list = List.new(title: "Minha Lista")
    assert list.valid?
  end

  test "não deve salvar sem título" do
    list = List.new(title: nil)
    assert_not list.valid?
    assert_includes list.errors[:title], "não pode ficar vazio"
  end

  test "não deve aceitar título curto" do
    list = List.new(title: "ab")
    assert_not list.valid?
    assert_includes list.errors[:title], "deve ter pelo menos 3 caracteres"
  end

  test "descrição não deve ultrapassar 500 caracteres" do
    list = List.new(
      title: "Lista válida",
      description: "a" * 501
    )

    assert_not list.valid?
    assert_includes list.errors[:description], "muito longa (máximo 500 caracteres)"
  end
end

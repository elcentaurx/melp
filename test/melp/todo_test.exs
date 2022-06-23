defmodule Melp.TodoTest do
  use Melp.DataCase

  alias Melp.Todo

  describe "todo_items" do
    alias Melp.Todo.TodoItem

    import Melp.TodoFixtures

    @invalid_attrs %{city: nil, email: nil, lat: nil, lng: nil, name: nil, phone: nil, rating: nil, site: nil, state: nil, street: nil}

    test "list_todo_items/0 returns all todo_items" do
      todo_item = todo_item_fixture()
      assert Todo.list_todo_items() == [todo_item]
    end

    test "get_todo_item!/1 returns the todo_item with given id" do
      todo_item = todo_item_fixture()
      assert Todo.get_todo_item!(todo_item.id) == todo_item
    end

    test "create_todo_item/1 with valid data creates a todo_item" do
      valid_attrs = %{city: "some city", email: "some email", lat: 120.5, lng: 120.5, name: "some name", phone: "some phone", rating: 42, site: "some site", state: "some state", street: "some street"}

      assert {:ok, %TodoItem{} = todo_item} = Todo.create_todo_item(valid_attrs)
      assert todo_item.city == "some city"
      assert todo_item.email == "some email"
      assert todo_item.lat == 120.5
      assert todo_item.lng == 120.5
      assert todo_item.name == "some name"
      assert todo_item.phone == "some phone"
      assert todo_item.rating == 42
      assert todo_item.site == "some site"
      assert todo_item.state == "some state"
      assert todo_item.street == "some street"
    end

    test "create_todo_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todo.create_todo_item(@invalid_attrs)
    end

    test "update_todo_item/2 with valid data updates the todo_item" do
      todo_item = todo_item_fixture()
      update_attrs = %{city: "some updated city", email: "some updated email", lat: 456.7, lng: 456.7, name: "some updated name", phone: "some updated phone", rating: 43, site: "some updated site", state: "some updated state", street: "some updated street"}

      assert {:ok, %TodoItem{} = todo_item} = Todo.update_todo_item(todo_item, update_attrs)
      assert todo_item.city == "some updated city"
      assert todo_item.email == "some updated email"
      assert todo_item.lat == 456.7
      assert todo_item.lng == 456.7
      assert todo_item.name == "some updated name"
      assert todo_item.phone == "some updated phone"
      assert todo_item.rating == 43
      assert todo_item.site == "some updated site"
      assert todo_item.state == "some updated state"
      assert todo_item.street == "some updated street"
    end

    test "update_todo_item/2 with invalid data returns error changeset" do
      todo_item = todo_item_fixture()
      assert {:error, %Ecto.Changeset{}} = Todo.update_todo_item(todo_item, @invalid_attrs)
      assert todo_item == Todo.get_todo_item!(todo_item.id)
    end

    test "delete_todo_item/1 deletes the todo_item" do
      todo_item = todo_item_fixture()
      assert {:ok, %TodoItem{}} = Todo.delete_todo_item(todo_item)
      assert_raise Ecto.NoResultsError, fn -> Todo.get_todo_item!(todo_item.id) end
    end

    test "change_todo_item/1 returns a todo_item changeset" do
      todo_item = todo_item_fixture()
      assert %Ecto.Changeset{} = Todo.change_todo_item(todo_item)
    end
  end
end

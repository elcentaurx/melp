defmodule MelpAppWeb.TodoItemControllerTestTest do
  use MelpWeb.ConnCase

  describe "index" do
    setup context do
      {:ok, conn: context.conn}
    end

    test "list all todo items", %{conn: conn}  do
      conn = get(conn, Routes.todo_item_path(conn, :index))
    end

  end

end

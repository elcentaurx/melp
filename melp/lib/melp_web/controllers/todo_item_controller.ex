defmodule MelpWeb.TodoItemController do
  use MelpWeb, :controller

  alias Melp.Todo
  alias Melp.Todo.TodoItem

  def index(conn, _params) do
    todo_items = Todo.list_todo_items()
    json put_status(conn, :ok), %{"restaurants" => "#{todo_items}"}
  end

  def new(conn, _params) do
    changeset = Todo.change_todo_item(%TodoItem{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"todo_item" => todo_item_params}) do
    #  todo_item_params |> Poison.decode!()
    todo_item_params |> IO.inspect(label: "=================>")
    # aux["todo_item"] |>
    case Todo.create_todo_item(todo_item_params) do
      {:ok, _todo_item} ->
        #conn
        # |> put_flash(:info, "Restaurant created successfully.")
        # |> redirect(to: Routes.todo_item_path(conn, :show, todo_item))

        json put_status(conn, :ok), %{"message" => "Restaurant created successfully"}

      {:error, _} -> #%Ecto.Changeset{} = changeset

        json put_status(conn, 401), %{"errors" => "Error al procesar la información"}

        # render(conn, "new.html", changeset: changeset)


      end
  end

  def show(conn, %{"id" => id}) do
    todo_item = Todo.get_todo_item!(id)
    render(conn, "show.html", todo_item: todo_item)
  end

  def edit(conn, %{"id" => id}) do
    todo_item = Todo.get_todo_item!(id)

    changeset = Todo.change_todo_item(todo_item)
    render(conn, "edit.html", todo_item: todo_item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "todo_item" => todo_item_params}) do
    todo_item = Todo.get_todo_item!(id)


    case Todo.update_todo_item(todo_item, todo_item_params) do
       {:ok, _todo_item} ->
      #   conn
      #   |> put_flash(:info, "Restaurant updated successfully.")
      #   |> redirect(to: Routes.todo_item_path(conn, :show, todo_item))
      render_json(conn, :ok, %{"message" => "Restaurant updated successfully."})

      {:error, %Ecto.Changeset{} = changeset} ->
        render_json(conn, :ok, %{"errors" => "#{changeset.data.__struct__.__schema__(:source)}" })

    end
  end

  def delete(conn, %{"id" => id}) do
    todo_item = Todo.get_todo_item!(id)
    {:ok, _todo_item} = Todo.delete_todo_item(todo_item)
    render_json(conn, :ok, %{"message" => "Restaurant deleted successfully."})
    # conn
    # |> put_flash(:info, "Restaurant deleted successfully.")
    # |> redirect(to: Routes.todo_item_path(conn, :index))

  end

  defp render_json(conn, status, response) do
		json put_status(conn, status), response
    end
end

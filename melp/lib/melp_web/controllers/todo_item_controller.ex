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
    todo_item_params
    case Todo.create_todo_item(todo_item_params) do
      {:ok, _todo_item} ->
        json put_status(conn, :ok), %{"message" => "Restaurant created successfully"}
      {:error,  %Ecto.Changeset{} = changeset} ->
        json put_status(conn, :ok), %{"errors" => "#{inspect(changeset.errors)}"}
      end
  end

  def show(conn, %{"id" => id}) do
    todo_item = Todo.get_todo_item(id)
    render(conn, "show.html", todo_item: todo_item)
  end

  def edit(conn, %{"id" => id}) do
    todo_item = Todo.get_todo_item(id)
    changeset = Todo.change_todo_item(todo_item)
    render(conn, "edit.html", todo_item: todo_item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "todo_item" => todo_item_params}) do
    todo_item = Todo.get_todo_item(id)
    case Todo.update_todo_item(todo_item, todo_item_params) do
       {:ok, _todo_item} ->
      render_json(conn, :ok, %{"message" => "Restaurant updated successfully."})

      {:error, %Ecto.Changeset{} = changeset} ->
        render_json(conn, :ok, %{"errors" => "#{inspect(changeset.errors)}" })
    end
  end

  def update_by_email(conn, %{"email" => email, "todo_item" => todo_item_params} ) do
    todo_email = Todo.get_email(email)
    case Todo.update_by_email(todo_email, todo_item_params) do
      {:ok, _todo_item} ->
     render_json(conn, :ok, %{"message" => "Restaurant updated successfully."})

     {:error, %Ecto.Changeset{} = changeset} ->
       render_json(conn, :ok, %{"errors" => "#{inspect(changeset.errors)}" })
   end

  end

  def delete_by_email(conn, %{"email" => email}) do
    todo_item =
      Todo.get_email(email)

      todo_item
      |> case do
        nil -> render_json(conn, :ok, %{"message" => "id not found"})
        _ ->
          Todo.delete_todo_item(todo_item)
          render_json(conn, :ok, %{"message" => "Restaurant deleted successfully."})
      end

  end

  def delete(conn, %{"id" => id}) do
    todo_item =
      Todo.get_todo_item(id)

      todo_item
      |> case do
        nil -> render_json(conn, :ok, %{"message" => "id not found"})
        _ ->
          Todo.delete_todo_item(todo_item)
          render_json(conn, :ok, %{"message" => "Restaurant deleted successfully."})
      end
  end

  def statistics(conn, %{"latitude" => latitude, "longitude" => longitude, "radius" => radius}) do
    data = Todo.get_restaurants(latitude, longitude, radius)
    render_json(conn, :ok, %{"message" => data})
  end

  defp render_json(conn, status, response) do
		json put_status(conn, status), response
    end
end

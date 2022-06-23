defmodule Melp.Todo do
  @moduledoc """
  The Todo context.
  """

  import Ecto.Query, warn: false
  alias Melp.Repo
  alias Melp.RestaurantLocateQuery
  alias Melp.Todo.TodoItem

  @doc """
  Returns the list of todo_items.

  ## Examples

      iex> list_todo_items()
      [%TodoItem{}, ...]

  """
  def list_todo_items do
    Repo.all(TodoItem)
  end

  @doc """
  Gets a single todo_item.

  Raises `Ecto.NoResultsError` if the Todo item does not exist.

  ## Examples

      iex> get_todo_item!(123)
      %TodoItem{}

      iex> get_todo_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_todo_item!(id), do: Repo.get!(TodoItem, id)

  def get_restaurants(lat, lng, radius) do
    geo = %Geo.Point{coordinates: {lat, lng}, srid: nil}
    TodoItem
    |> Repo.all
    |> Enum.map(fn f ->  f |> Map.put(:status, f |> get_coordinate(geo, radius))  end)
    |> IO.inspect(label: "HERE=========================>")

  end

  def get_coordinate(param, geo, radius) do
    RestaurantLocateQuery.get_restaurants(param.id, geo, radius) |> Repo.one
  end

  def filter_restaurants(params) do
    (params |> Enum.filter(fn f -> f.status end))
    |> length()
  end

  def avg_restaurants(filter_list, len) do
    sum = filter_list |> Enum.map(fn f -> f.rating end)
    |> Enum.sum()
    sum/len
  end





  @doc """
  Creates a todo_item.

  ## Examples

      iex> create_todo_item(%{field: value})
      {:ok, %TodoItem{}}

      iex> create_todo_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_todo_item(attrs ) do
    attrs = attrs |> Map.put("coordinates", %Geo.Point{coordinates: {attrs["lat"], attrs["lng"]}, properties: %{}, srid: nil} )
    %TodoItem{}
    |> TodoItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a todo_item.

  ## Examples

      iex> update_todo_item(todo_item, %{field: new_value})
      {:ok, %TodoItem{}}

      iex> update_todo_item(todo_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_todo_item(%TodoItem{} = todo_item, attrs) do
    todo_item
    |> TodoItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a todo_item.

  ## Examples

      iex> delete_todo_item(todo_item)
      {:ok, %TodoItem{}}

      iex> delete_todo_item(todo_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_todo_item(%TodoItem{} = todo_item) do
    Repo.delete(todo_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking todo_item changes.

  ## Examples

      iex> change_todo_item(todo_item)
      %Ecto.Changeset{data: %TodoItem{}}

  """
  def change_todo_item(%TodoItem{} = todo_item, attrs \\ %{}) do
    TodoItem.changeset(todo_item, attrs)
  end
end
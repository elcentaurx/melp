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

      iex> get_todo_item(123)
      %TodoItem{}

      iex> get_todo_item(456)
      nil

  """
  def get_todo_item(id), do: Repo.get(TodoItem, id)

    @doc """
  Gets a list with avg, count, deviation.

  Raises `Ecto.NoResultsError` if the Todo item does not exist.

  ## Examples

      iex> get_todo_item(lat, lng, radius)
      %{avg: _, count: _, radius: _}


  """

  def get_restaurants(lat, lng, radius) do
    geo = %Geo.Point{coordinates: {lat |> String.to_float, lng |> String.to_float}, srid: nil}
    radius = radius |> String.to_float
    list = TodoItem |> Repo.all
      list
      |> case do
        [] ->
          %{}
        |> Map.put(:count, 0)
        |> Map.put(:avg, 0)
        |> Map.put(:deviation, nil)
        _ ->
        list_with_status =
          list
          |> Enum.map(fn f ->  f |> Map.put(:status, f.id |> get_coordinate(geo, f.coordinates, radius))   end)
          filter_list =  list_with_status |>  filter_restaurants
          avg_rest = filter_list |> avg_restaurants
          len = filter_list |> length
          avg = if len > 0, do: avg_rest/len, else: 0
          deviat = avg |> deviation(filter_list)
          %{}
          |> Map.put(:count, len)
          |> Map.put(:avg, avg)
          |> Map.put(:deviation, deviat)
      end


  end

  @doc """
  Gets a single restaurant.

  Raises `Ecto.NoResultsError` if the Todo item does not exist.

  ## Examples

      iex> get_point(id)
      %TodoItem{}

      iex> get_point(id)
      nil

  """

  def get_point(id) do
    id |> RestaurantLocateQuery.get_point |> Repo.all
  end


  @doc """
  Gets a List with values when geometry in a range.

  Raises `Ecto.NoResultsError` if the Todo item does not exist.

  ## Examples

      iex> get_coordinate(id, point, geo, radious)
      List

      iex> get_coordinate(id, point, geo, radious)
      []

  """

  def get_coordinate(id, point, geo, radius) do
    RestaurantLocateQuery.get_restaurants(id, point, geo, radius) |> Repo.all
  end


  @doc """
  Gets a filter list.


  ## Examples

      iex> filter_restaurants(list)
      List

      iex> get_coordinate(list)
      []

  """

  def filter_restaurants(params) do
    (params |> Enum.filter(fn f -> f.status == [true] end))
  end


  @doc """
  Gets a sum of rating of the restaurants in the list.


  ## Examples

      iex> avg_restaurants(filter_list)
      10.0

      iex> avg_restaurants(filter_list)
      9.0
  """

  def avg_restaurants(filter_list) do

    filter_list
    |> case do
      [] -> 0
      _ ->
        filter_list
          |> Enum.map(fn f -> f.rating end)
          |> Enum.sum()
    end

  end


  @doc """
  Gets a deviation.


  ## Examples

      iex> deviation(avg, filter_list)
      10.0

      iex> deviation(filter_list)
      9.0
  """

  def deviation(avg, filter_list) do
    len = filter_list |> length

    filter_list
    |> case do
      [] -> nil
      _ ->
        sum = filter_list
          |> Enum.map(fn f -> ((((f.rating |> string_float  ) - avg) |> Float.pow(2)))  end)
          |> Enum.sum()
        (sum / len) |> Float.pow(2)
    end

  end

   @doc """
  Gets a float number when the number is integer or string.


  ## Examples

      iex> string_float(10)
      10.0

      iex> string_float("9")
      9.0
  """

  def string_float(integer) do
    float = integer |> Integer.to_string()
    value = float
      |> String.contains?(".")
      |> case do
        true -> float
        false -> float <> ".0" |> String.to_float()
      end
    value
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
  Gets a single todo_item by email.

  Raises `Ecto.NoResultsError` if the Todo item does not exist.

  ## Examples

      iex> get_email(email)
      %TodoItem{}

      iex> get_email(email)
      nil

  """


  def get_email(email) do
    email
    |> RestaurantLocateQuery.get_by_email()
    |> Repo.one
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

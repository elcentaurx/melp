defmodule Melp.RestaurantLocateQuery do
  import Ecto.Query, warn: false
  alias Melp.Todo.TodoItem
  import Geo.PostGIS

  @doc """
  Search a restaurant.

  ## Examples

      iex> get_point(%{id: id})
      {:ok, %TodoItem{}}

      iex> get_point(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  def get_point(id) do
    from r in TodoItem,
    where: r.id == ^id
  end
  @doc """
  Search an restaurants in a range.

  ## Examples

      iex> get_point(%{id: uuid, geo: geometry, point: coordinates as geometry, radious: float})
      {:ok, List}}

      iex> get_point(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  def get_restaurants(id, geo, point, radius) do
    from r in TodoItem,
      where: r.id == ^id,
      select:
      Geo.PostGIS.st_dwithin_in_meters(^geo, ^point , ^radius)

  end

  @doc """
  Search a restaurant.

  ## Examples

      iex> get_point(%{email: email})
      {:ok, %TodoItem{}}}

      iex> get_point(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  def get_by_email(email) do
    from r in TodoItem,
    where: r.email == ^email

  end

end

defmodule Melp.RestaurantLocateQuery do
  import Ecto.Query, warn: false
  alias Melp.Todo.TodoItem
  import Geo.PostGIS

  def get_point(id) do
    from r in TodoItem,
    where: r.id == ^id
  end
  def get_restaurants(id, geo, point, radius) do
    from r in TodoItem,
      where: r.id == ^id,
      select:
      Geo.PostGIS.st_dwithin_in_meters(^geo, ^point , ^radius)

  end

  def get_by_email(email) do
    from r in TodoItem,
    where: r.email == ^email

  end

end

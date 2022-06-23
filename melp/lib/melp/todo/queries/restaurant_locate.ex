defmodule Melp.RestaurantLocateQuery do
  import Ecto.Query, warn: false
  alias Melp.Todo.TodoItem
  import Geo.PostGIS

  def get_restaurants(id, geo, radius) do
    from r in TodoItem,
     where: r.id == ^id,

      select:
      st_dwithin_in_meters(r.coordinates, ^geo, ^radius),
      limit: 1
      # name: r.name,
      # id: r.id,
      # site: r.site,
      # count: count(r.id),

  end

end
#where: fragment("(ST_SetSRID(ST_MakePoint(?, ?), ?), ?)", ^lng, ^lat, 6362, ^radius_in_m)

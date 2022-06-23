defmodule Melp do
  Postgrex.Types.define(Melp.PostgresTypes,
              [Geo.PostGIS.Extension] ++ Ecto.Adapters.Postgres.extensions(),
              json: Jason)
  @moduledoc """
  Melp keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
end

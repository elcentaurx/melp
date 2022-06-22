defmodule Melp.Repo do
  use Ecto.Repo,
    otp_app: :melp,
    adapter: Ecto.Adapters.Postgres
end

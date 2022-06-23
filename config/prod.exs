use Mix.Config

config :melp, MelpWeb.Endpoint,
  load_from_system_env: true,
  http: [port: {:system, "PORT"}],
  server: true,
  secret_key_base: "${SECRET_KEY_BASE}",
  url: [host: "${APP_NAME}.gigalixirapp.com", port: 443],
  cache_static_manifest: "priv/static/cache_manifest.json"

config :melp, Melp.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: "${DATABASE_URL}",
  database: "", # Works around a bug in older versions of ecto. Doesn't hurt for other versions.
  ssl: true,
  pool_size: 2, # Free tier
  adapter: Ecto.Adapters.Postgres,
  types: Melp.PostgresTypes

# Do not print debug messages in production
config :logger, level: :info

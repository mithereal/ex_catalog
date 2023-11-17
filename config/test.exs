import Config
# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

config :ex_catalog, :ecto_repos, [ExCatalog.Repo]

config :ex_catalog, ExCatalog.Repo,
  adapter: Ecto.Adapters.SQL.Sandbox,
  username: "postgres",
  password: "postgres",
  database: "ex_catalog",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10,
  primary_key_type: :uuid

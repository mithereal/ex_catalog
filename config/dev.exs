import Config
# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

config :ex_catalog, :ecto_repos, [ExCatalog.Repo]

# config :ex_checkout, ExCheckout.Repo,
#  adapter: Ecto.Adapters.Postgres,
#  username: "postgres",
#  password: "postgres",
#  database: "ex_checkout",
#  hostname: "localhost",
#  port: 5433,
#  pool_size: 10

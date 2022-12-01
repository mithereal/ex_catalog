import Config
# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

config :ex_catalog, :ecto_repos, [ExCatalog.Repo.Null]

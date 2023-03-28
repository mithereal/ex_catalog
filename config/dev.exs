import Config
# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

config :ex_money,
  exchange_rates_retrieve_every: 300_000,
  api_module: Money.ExchangeRates.OpenExchangeRates,
  callback_module: Money.ExchangeRates.Callback,
  exchange_rates_cache_module: Money.ExchangeRates.Cache.Ets,
  preload_historic_rates: nil,
  retriever_options: nil,
  log_failure: :warn,
  log_info: :info,
  log_success: nil,
  json_library: Jason,
  default_cldr_backend: ExCatalog.Cldr

config :ex_catalog, :ecto_repos, [ExCatalog.Repo]

config :ex_catalog, ExCatalog.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "ex_catalog",
  hostname: "localhost",
  port: 55432,
  pool_size: 10,
  key_type: :uuid

# ExCatalog

[![Coverage Status](https://coveralls.io/repos/github/mithereal/ex_catalog/badge.svg?branch=main)](https://coveralls.io/github/mithereal/ex_catalog?branch=main)
![CircleCI](https://img.shields.io/circleci/build/github/mithereal/ex_catalog)
[![Version](https://img.shields.io/hexpm/v/ex_catalog.svg?style=flat-square)](https://hex.pm/packages/ex_catalog)
![GitHub](https://img.shields.io/github/license/mithereal/ex_catalog)
![GitHub last commit (branch)](https://img.shields.io/github/last-commit/mithereal/ex_catalog/main)

** A General E-commerce Catalog System **

Think of this like an old school paper mail in catalog, we dont need all the fluff (extra db tables etc) as in in most ecommerce implementations, this is just a catalog, decoupled from inventory management with some options such as csv and pdf export, integer or binary primary key.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_catalog` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_catalog, ">= 0.0.0"}
  ]
end
```

## Creating the Database Tables

The Database Tables can be created by running the mix alias.

```elixir
mix install
```

## Config

Add the following to your config.exs
```elixir
config :ex_catalog, :ecto_repos, [ExCatalog.Repo]

config :ex_cldr,
  json_library: Jason
```

Add the following to your dev and/or prod config
```elixir
config :ex_catalog, :ecto_repos, [ExCatalog.Repo]

config :ex_catalog, ExCatalog.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "ex_catalog_dev",
  hostname: "localhost",
  pool_size: 10,
  primary_key_type: :uuid ## optional
```

## Generate a migration
```elixir
mix ExCatalog.install
```

## (Optional) startup config options for using currency autoloader etc
```elixir
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
  
config :ex_catalog, :autoload_exchange_rates, true 
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/ex_catalog>.


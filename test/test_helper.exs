ExUnit.start()

alias ExCatalog.Config

Ecto.Adapters.SQL.Sandbox.mode(Config.repo(), :manual)

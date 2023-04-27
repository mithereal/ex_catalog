defmodule ExCatalogTest do
  use ExUnit.Case, async: true
  doctest ExCatalog

  alias ExCatalog.Config

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Config.repo())
  end

  test "check the version" do
    assert ExCatalog.version() == Mix.Project.config()[:version]
  end
end

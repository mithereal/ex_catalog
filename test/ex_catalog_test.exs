defmodule ExCatalogTest do
  use ExUnit.Case
  doctest ExCatalog

  test "check the version" do
    assert ExCatalog.version() == Mix.Project.config()[:version]
  end
end

defmodule ExCatalogTest do
  use ExUnit.Case
  doctest ExCatalog

  test "greets the world" do
    assert ExCatalog.hello() == :world
  end
end

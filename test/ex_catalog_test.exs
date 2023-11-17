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

  test "test products" do
    assert ExCatalog.products(25) == {[],
             %Paginator.Page.Metadata{
               after: nil,
               before: nil,
               limit: 25,
               total_count: 0,
               total_count_cap_exceeded: false
             }}
  end

  test "test product" do
    price = Money.new(:USD, 100)
    product = %{sku: "12345", price: price, title: "test product", sub_title: "test product", description: "test product"}

    ExCatalog.Product.new product

    assert ExCatalog.product("12345", :USD).sku == "12345"
  end

  test "test product" do
    price = Money.new(:USD, 100)
    product = %{sku: "12345", price: price, title: "test product", sub_title: "test product", description: "test product"}

    ExCatalog.Product.new product

    assert ExCatalog.product("12345", :USD).sku == "12345"
  end
end

defmodule ExCatalog.Product.Category do
  @moduledoc false
  use ExCatalog.Schema

  schema "catalog_product_categories" do
    belongs_to(:category, ExCatalog.Category, type: ExCatalog.Config.key_type())
    belongs_to(:product, ExCatalog.Product, type: ExCatalog.Config.key_type())
  end
end

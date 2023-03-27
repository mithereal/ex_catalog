defmodule ExCatalog.Product.Category do
  use Ecto.Schema

  schema "catalog_product_categories" do
    belongs_to(:category, ExCatalog.Category)
    belongs_to(:product, ExCatalog.Product)
  end
end

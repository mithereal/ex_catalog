defmodule ExCatalog.Product.Variation do
  use Ecto.Schema

  schema "catalog_product_variations" do
    belongs_to(:parent, ExCatalog.Product)
    belongs_to(:product, ExCatalog.Product)
  end
end

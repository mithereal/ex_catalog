defmodule ExCatalog.Product.Variation do
  @moduledoc false
  use Ecto.Schema

  schema "catalog_product_variations" do
    field(:title, :string)

    belongs_to(:parent, ExCatalog.Product, type: ExCatalog.Config.key_type())
    belongs_to(:product, ExCatalog.Product, type: ExCatalog.Config.key_type())
  end
end

defmodule ExCatalog.Product.Variation do
  @moduledoc false
  use ExCatalog.Schema
  use EctoAutoslugField.Slug, from: :title, to: :slug
  use ExCatalog.AutoSlug

  alias ExCatalog.Product.Variation.TitleSlug

  schema "catalog_product_variations" do
    field(:title, :string)
    field(:slug, TitleSlug.Type)

    belongs_to(:parent, ExCatalog.Product, type: ExCatalog.Config.key_type())
    belongs_to(:product, ExCatalog.Product, type: ExCatalog.Config.key_type())
  end
end

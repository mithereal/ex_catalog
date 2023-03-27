defmodule ExCatalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "catalog_products" do
    field(:sku, :string)
    field(:price, Money.Ecto.Composite.Type)
    field(:title, :string)
    field(:sub_title, :string)
    field(:description, :string)

    belongs_to(:primary_image, ExCatalog.Image)

    many_to_many :variations, ExCatalog.Product, join_through: ExCatalog.Product.Variation, on_replace: :delete
    many_to_many :categories, ExCatalog.Category, join_through: ExCatalog.Product.Category, on_replace: :delete

    has_many :images, ExCatalog.Image, on_replace: :delete
    has_many :metas, ExCatalog.Meta, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:sku, :price, :title, :sub_title, :description])
    |> validate_required([:sku, :price, :title, :sub_title, :description])
  end
end

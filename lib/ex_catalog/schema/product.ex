defmodule ExCatalog.Product do
  use ExCatalog.Schema, type: ExCatalog.Config.key_type()
  import Ecto.Changeset

  schema "catalog_products" do
    field(:sku, :string)
    field(:price, Money.Ecto.Composite.Type)
    field(:title, :string)
    field(:sub_title, :string)
    field(:description, :string)

    belongs_to(:primary_image, ExCatalog.Image, type: ExCatalog.Config.key_type())

    many_to_many(:variations, ExCatalog.Product,
      join_through: ExCatalog.Product.Variation,
      on_replace: :delete
    )

    many_to_many(:categories, ExCatalog.Category,
      join_through: ExCatalog.Product.Category,
      on_replace: :delete
    )

    has_many(:images, ExCatalog.Image, on_replace: :delete)

    has_many(:metas, ExCatalog.Meta, on_replace: :delete)

    timestamps()
  end

  @doc false
  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:sku, :price, :title, :sub_title, :description, :primary_image_id])
    |> validate_required([:sku, :price, :title, :sub_title, :description])
  end
end

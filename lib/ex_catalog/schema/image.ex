defmodule ExCatalog.Image do
  use ExCatalog.Schema
  import Ecto.Changeset

  schema "catalog_images" do
    field(:title, :string)
    field(:description, :string)
    field(:path, :string)
    field(:height, :float)
    field(:width, :float)
    belongs_to(:product, ExCatalog.Product)
  end

  @doc false
  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:path, :description, :width, :height, :product_id])
    |> validate_required([:path, :name, :width, :height])
  end

  @doc false
  def changeset_assoc(schema, attrs) do
    schema
    |> changeset(attrs)
    |> put_assoc(:product, ExCatalog.Product, attrs[:product])
  end
end

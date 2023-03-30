defmodule ExCatalog.Meta do
  use ExCatalog.Schema
  import Ecto.Changeset

  schema "catalog_metas" do
    field(:key, :string)
    field(:data, :map)
    belongs_to(:product, ExCatalog.Product)
  end

  @doc false
  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:key, :data, :product_id])
    |> validate_required([:key, :data])
  end

  @doc false
  def changeset_assoc(schema, attrs) do
    schema
    |> changeset(attrs)
    |> put_assoc(:product, ExCatalog.Product, attrs[:product])
  end
end

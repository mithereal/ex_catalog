defmodule ExCatalog.Meta do
  use Ecto.Schema
  import Ecto.Changeset

  schema "catalog_metas" do
    field(:key, :string)
    field(:data, :string)
    belongs_to(:product, ExCatalog.Product)
  end

  @doc false
  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:key, :data])
    |> validate_required([:key, :data])
  end
end

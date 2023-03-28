defmodule ExCatalog.Meta do
  use ExCatalog.Schema, type: ExCatalog.Config.key_type()
  import Ecto.Changeset

  schema "catalog_metas" do
    field(:key, :string)
    field(:data, :string)
    belongs_to(:product, ExCatalog.Product, type: ExCatalog.Config.key_type())
  end

  @doc false
  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:key, :data])
    |> validate_required([:key, :data])
  end
end

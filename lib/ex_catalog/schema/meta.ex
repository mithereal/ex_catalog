defmodule ExCatalog.Meta do
  use ExCatalog.Schema, type: Application.get_env(:ex_catalog, :key_type, :integer)
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

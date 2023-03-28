defmodule ExCatalog.Video do
  use ExCatalog.Schema, type: ExCatalog.Config.key_type()
  import Ecto.Changeset

  schema "catalog_videos" do
    field(:path, :string)
    belongs_to(:product, ExCatalog.Product, type: ExCatalog.Config.key_type())
  end

  @doc false
  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:path, :product])
    |> validate_required([:path, :product])
  end
end

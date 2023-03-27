defmodule ExCatalog.Video do
  use Ecto.Schema
  import Ecto.Changeset

  schema "catalog_videos" do
    field(:path, :string)
    belongs_to(:product, ExCatalog.Product)
  end

  @doc false
  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:path, :product])
    |> validate_required([:path, :product])
  end
end

defmodule ExCatalog.Image do
  use ExCatalog.Schema, type: Application.get_env(:ex_catalog, :key_type, :integer)
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
    |> cast(attrs, [:path, :description, :width, :height])
    |> validate_required([:path, :name, :width, :height])
  end
end

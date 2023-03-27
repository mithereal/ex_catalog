defmodule ExCatalog.Category do
  use Ecto.Schema
  import Ecto.Changeset

  schema "catalog_categories" do
    field(:title, :string)
    field(:description, :string)
    field(:sort_order, :string)

    belongs_to(:parent_category, ExCatalog.Category)
    belongs_to(:image, ExCatalog.Image)
  end

  def changeset(schema, attrs) do
    changeset =
      schema
      |> cast(attrs, [:title, :description, :parent_category, :sort_order, :image])
  end
end

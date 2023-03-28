defmodule ExCatalog.Category do
  use ExCatalog.Schema
  use EctoAutoslugField.Slug, from: :title, to: :slug
  use ExCatalog.AutoSlug
  import Ecto.Changeset

  alias ExCatalog.Category.TitleSlug

  schema "catalog_categories" do
    field(:title, :string)
    field(:description, :string)
    field(:sort_order, :string)

    field(:slug, TitleSlug.Type)

    belongs_to(:parent_category, ExCatalog.Category)
    belongs_to(:image, ExCatalog.Image)
  end

  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [
      :title,
      :description,
      :image,
      :sort_order,
      :parent_category_id,
      :image_id
    ])
    |> TitleSlug.maybe_generate_slug()
    |> TitleSlug.unique_constraint()
  end

  @doc false
  def changeset_assoc(schema, attrs) do
    schema
    |> changeset(attrs)
    |> put_assoc(:parent_category, ExCatalog.Category, attrs[:parent_category])
    |> put_assoc(:image, ExCatalog.Image, attrs[:image])
  end
end

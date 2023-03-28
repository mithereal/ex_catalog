defmodule ExCatalog.Category do
  use ExCatalog.Schema, type: ExCatalog.Config.key_type()
  use EctoAutoslugField.Slug, from: :title, to: :slug
  use ExCatalog.AutoSlug
  import Ecto.Changeset

  alias ExCatalog.Category.TitleSlug

  schema "catalog_categories" do
    field(:title, :string)
    field(:description, :string)
    field(:sort_order, :string)

    field(:slug, TitleSlug.Type)

    belongs_to(:parent_category, ExCatalog.Category, type: ExCatalog.Config.key_type())
    belongs_to(:image, ExCatalog.Image, type: ExCatalog.Config.key_type())
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
    |> put_assoc(:parent_category, ExCatalog.Category)
    |> put_assoc(:image, ExCatalog.Image)
  end
end

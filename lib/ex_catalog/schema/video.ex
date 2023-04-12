defmodule ExCatalog.Video do
  use ExCatalog.Schema
  import Ecto.Changeset
  use EctoAutoslugField.Slug, from: :title, to: :slug
  use ExCatalog.AutoSlug

  alias ExCatalog.Video.TitleSlug

  schema "catalog_videos" do
    field(:path, :string)
    belongs_to(:product, ExCatalog.Product)

    field(:slug, TitleSlug.Type)
  end

  @doc false
  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:path, :product_id])
    |> validate_required([:path])
  end

  @doc false
  def changeset_assoc(schema, attrs) do
    schema
    |> changeset(attrs)
    |> put_assoc(:product, ExCatalog.Product, attrs[:product])
  end
end

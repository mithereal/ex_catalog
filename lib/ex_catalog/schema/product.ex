defmodule ExCatalog.Product do
  use ExCatalog.Schema
  import Ecto.Changeset
  import Ecto.SoftDelete.Schema
  use EctoAutoslugField.Slug, from: :title, to: :slug
  use ExCatalog.AutoSlug

  alias ExCatalog.Product.TitleSlug

  @repo ExCatalog.Config.repo()

  schema "catalog_products" do
    field(:sku, :string)
    field(:price, Money.Ecto.Composite.Type)
    field(:title, :string)
    field(:sub_title, :string)
    field(:description, :string)
    field(:model, :string)
    field(:origin, :string)
    field(:owner_id, @foreign_key_type)

    field(:slug, TitleSlug.Type)

    belongs_to(:primary_image, ExCatalog.Image)

    belongs_to(:manufacturer, ExCatalog.Manufacturer)

    many_to_many(:variations, ExCatalog.Product,
      join_through: ExCatalog.Product.Variation,
      on_replace: :delete
    )

    many_to_many(:categories, ExCatalog.Category,
      join_through: ExCatalog.Product.Category,
      on_replace: :delete
    )

    has_many(:images, ExCatalog.Image, on_replace: :delete)
    has_many(:videos, ExCatalog.Video, on_replace: :delete)
    has_many(:metas, ExCatalog.Meta, on_replace: :delete)

    timestamps()
    soft_delete_schema()
  end

  @doc false
  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [
      :sku,
      :price,
      :title,
      :model,
      :sub_title,
      :description,
      :primary_image_id,
      :owner_id,
      :origin
    ])
    |> validate_required([:sku, :price, :title, :sub_title, :description])
    |> TitleSlug.maybe_generate_slug()
    |> TitleSlug.unique_constraint()
  end

  @doc false
  def changeset_assoc(schema, attrs) do
    primary_image = attrs[:primary_image] || []
    images = attrs[:images] || []
    categories = attrs[:categories] || []
    metas = attrs[:metas] || []
    variations = attrs[:variations] || []
    manufacturer = attrs[:manufacturer] || []

    schema
    |> changeset(attrs)
    |> cast_assoc(:primary_image, primary_image)
    |> cast_assoc(:images, images)
    |> cast_assoc(:categories, categories)
    |> cast_assoc(:metas, metas)
    |> cast_assoc(:variations, variations)
    |> cast_assoc(:manufacturer, manufacturer)
  end

  @doc """
  Create a New Product

  ## Examples

      iex> price = Money.new(:USD, 100)
      iex> product = %{sku: "12345", price: price, title: "test product", sub_title: "test product", description: "test product"}
      iex> ExCatalog.Product.new(product)


  """
  def new(params \\ %{}, struct \\ %ExCatalog.Product{}) do
    struct
    |> changeset(params)
    |> @repo.insert()
  end
end

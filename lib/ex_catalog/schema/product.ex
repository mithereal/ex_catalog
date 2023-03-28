defmodule ExCatalog.Product do
  use ExCatalog.Schema, type: ExCatalog.Config.key_type()
  import Ecto.Changeset

  @repo ExCatalog.Config.repo()

  schema "catalog_products" do
    field(:sku, :string)
    field(:price, Money.Ecto.Composite.Type)
    field(:title, :string)
    field(:sub_title, :string)
    field(:description, :string)

    belongs_to(:primary_image, ExCatalog.Image, type: ExCatalog.Config.key_type())

    many_to_many(:variations, ExCatalog.Product,
      join_through: ExCatalog.Product.Variation,
      on_replace: :delete
    )

    many_to_many(:categories, ExCatalog.Category,
      join_through: ExCatalog.Product.Category,
      on_replace: :delete
    )

    has_many(:images, ExCatalog.Image, on_replace: :delete)
    has_many(:metas, ExCatalog.Meta, on_replace: :delete)

    timestamps()
  end

  @doc false
  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:sku, :price, :title, :sub_title, :description, :primary_image_id])
    |> validate_required([:sku, :price, :title, :sub_title, :description])
  end

  @doc false
  def changeset_assoc(schema, attrs) do
    images = attrs[:images] || []
    categories = attrs[:categories] || []
    metas = attrs[:metas] || []
    variations = attrs[:variations] || []

    schema
    |> changeset(attrs)
    |> put_assoc(:primary_image, ExCatalog.Image, attrs[:image])
    |> put_assoc(:images, images)
    |> put_assoc(:categories, categories)
    |> put_assoc(:metas, metas)
    |> put_assoc(:variations, variations)
  end

  @doc """
  Create a New Product

  ## Examples

      iex> ExCatalog.new()


  """
  def new(struct \\ %ExCatalog.Product{}, params \\ %{}) do
    struct
    |> changeset_assoc(params)
    |> @repo.insert()
  end
end

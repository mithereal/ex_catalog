defmodule ExCatalog.Manufacturers do
  use ExCatalog.Schema
  import Ecto.Changeset
  use EctoAutoslugField.Slug, from: :title, to: :slug
  use ExCatalog.AutoSlug

  alias ExCatalog.Manufacturer.TitleSlug

  @repo ExCatalog.Config.repo()

  schema "catalog_manufacturers" do
    field(:title, :string)
    field(:description, :string)

    field(:slug, TitleSlug.Type)
  end

  @doc false
  def changeset(schema, attrs) do
    schema
    |> cast(attrs, [:title, :description])
    |> validate_required([:title])
  end

  @doc false
  def changeset_assoc(schema, attrs) do
    schema
    |> changeset(attrs)
  end

  @doc """
  Create a New Manufacturer

  ## Examples

      iex> manufacturer = %{title: "test Manufacturer", description: "test Manufacturers"}
      iex> ExCatalog.Manufacturers.new(manufacturer)


  """
  def new(params \\ %{}, struct \\ %ExCatalog.Product{}) do
    struct
    |> changeset(params)
    |> @repo.insert()
  end
end

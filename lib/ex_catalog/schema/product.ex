defmodule ExCatalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "product" do
    field(:sku, :string)
    field(:price, Money.Ecto.Composite.Type)
    field(:title, :string)
    field(:sub_title, :string)
    field(:description, :string)
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:sku, :price, :title, :sub_title, :description])
    |> validate_required([:sku, :price, :title, :sub_title, :description])
  end
end

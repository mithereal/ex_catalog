defmodule ExCatalog.Product.Category do
  use Ecto.Schema
  import Ecto.Changeset

  schema "meta" do
    belongs_to(:category,  ExCatalog.Category)
    belongs_to(:product, ExCatalog.Product)
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:category, :product])
    |> validate_required([:category, :product])
  end
end

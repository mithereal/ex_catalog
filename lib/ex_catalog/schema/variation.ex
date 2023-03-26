defmodule ExCatalog.Product.Variation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "product_variation" do
    belongs_to(:parent, ExCatalog.Product)
    belongs_to(:product, ExCatalog.Product)
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:parent, :product])
    |> validate_required([:parent, :product])
  end
end

defmodule ExCatalog.Video do
  use Ecto.Schema
  import Ecto.Changeset

  schema "product_variation" do
    field(:path, :string)
    belongs_to(:product, ExCatalog.Product)
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:path, :product])
    |> validate_required([:path, :product])
  end
end


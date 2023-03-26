defmodule ExCatalog.Image do
  use Ecto.Schema
  import Ecto.Changeset

  schema "images" do
    field(:title, :string)
    field(:description, :string)
    field(:path, :string)
    field(:height, :float)
    field(:width, :float)
    belongs_to(:product, ExCatalog.Product)
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:path, :description, :width, :height])
    |> validate_required([:path, :name, :width, :height])
  end
end

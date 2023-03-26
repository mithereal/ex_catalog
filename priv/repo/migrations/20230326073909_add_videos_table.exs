defmodule ExCatalog.Repo.Migrations.AddVideosTable do
  use Ecto.Migration

  def change do
    add(:path, :string)

    add :product_id, references(:products, on_delete: :nothing)
  end
end

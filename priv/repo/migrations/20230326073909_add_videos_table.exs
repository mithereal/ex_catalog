defmodule ExCatalog.Repo.Migrations.AddVideosTable do
  use Ecto.Migration

  def change do
    create table(:catalog_videos) do
    add(:path, :string)

    add :product_id, references(:catalog_products, on_delete: :nothing)
  end
  end
end

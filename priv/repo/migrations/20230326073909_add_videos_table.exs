defmodule ExCatalog.Repo.Migrations.AddVideosTable do
  use Ecto.Migration

  def change do
    key_type = ExCatalog.Config.key_type(:migration)

    create table(:catalog_videos, primary_key: false) do
      add(:id, key_type, primary_key: true)
      add(:path, :string)

      add(:product_id, references(:catalog_products, on_delete: :nothing))
    end
  end
end

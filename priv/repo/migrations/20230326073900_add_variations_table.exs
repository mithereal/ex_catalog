defmodule ExCatalog.Repo.Migrations.AddVariationsTable do
  use Ecto.Migration

  def change do
    key_type = ExCatalog.Config.key_type()

    create table(:catalog_product_variations, primary_key: false) do
      add(:id, key_type, primary_key: true)
      add(:parent_id, references(:catalog_products, on_delete: :nothing))
      add(:product_id, references(:catalog_products, on_delete: :nothing))
    end
  end
end

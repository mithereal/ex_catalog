defmodule ExCatalog.Repo.Migrations.AddVariationsTable do
  use Ecto.Migration

  def change do
    key_type = ExCatalog.Config.key_type(:migration)

    create table(:catalog_product_variations, primary_key: false) do
      add(:id, key_type, primary_key: true)
      add(:parent_id, references(:catalog_products, on_delete: :nothing, type: key_type))
      add(:product_id, references(:catalog_products, on_delete: :nothing, type: key_type))
    end
  end
end

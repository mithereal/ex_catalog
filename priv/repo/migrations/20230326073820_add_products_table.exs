defmodule ExCatalog.Repo.Migrations.AddProductsTable do
  use Ecto.Migration
  import Ecto.SoftDelete.Migration

  def change do
    key_type = ExCatalog.Config.key_type(:migration)

    create table(:catalog_products, primary_key: false) do
      add(:id, key_type, primary_key: true)
      add(:title, :string)
      add(:sub_title, :string)
      add(:description, :string)
      add(:sku, :string)
      add(:price, :money_with_currency)
      add(:owner_id, @foreign_key_type)
      add(:slug, :string, null: false)

      timestamps()
      soft_delete_columns()

      add(:image_id, references(:catalog_images, on_delete: :nothing, type: key_type))
      add(:primary_image_id, references(:catalog_images, on_delete: :nothing, type: key_type))
    end

    alter table(:catalog_metas) do
      add(:product_id, references(:catalog_products, on_delete: :nothing, type: key_type))
    end
  end
end

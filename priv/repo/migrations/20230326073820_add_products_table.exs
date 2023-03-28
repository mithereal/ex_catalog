defmodule ExCatalog.Repo.Migrations.AddProductsTable do
  use Ecto.Migration

  def change do
    key_type = ExCatalog.Config.key_type()

    create table(:catalog_products, primary_key: false) do
      add(:id, key_type, primary_key: true)
      add(:title, :string)
      add(:sub_title, :string)
      add(:description, :string)
      add(:sku, :string)
      add(:price, :money_with_currency)

      timestamps()

      add(:image_id, references(:catalog_images, on_delete: :nothing))
      add(:primary_image_id, references(:catalog_images, on_delete: :nothing))
    end

    alter table(:catalog_metas) do
      add(:product_id, references(:catalog_products, on_delete: :nothing))
    end
  end
end

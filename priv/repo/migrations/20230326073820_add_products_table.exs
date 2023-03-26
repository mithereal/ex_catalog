defmodule ExCatalog.Repo.Migrations.AddProductsTable do
  use Ecto.Migration

  def change do
    create table(:catalog_products) do
      add(:title, :string)
      add(:sub_title, :string)
      add(:description, :string)
      add(:sku, :string)
      add(:price, Money.Ecto.Composite.Type)

      add :image_id, references(:catalog_images, on_delete: :nothing)
      add :primary_image_id, references(:catalog_images, on_delete: :nothing)
    end

    alter table(:catalog_metas) do
      add(:product_id, references(:catalog_products, on_delete: :nothing))
    end
  end
end

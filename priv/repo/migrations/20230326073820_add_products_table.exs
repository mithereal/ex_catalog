defmodule ExCatalog.Repo.Migrations.AddProductsTable do
  use Ecto.Migration

  def change do
    key_type = Application.get_env(:ex_catalog, :key_type, :integer)

    create table(:catalog_products, primary_key: false) do
      add(:id, key_type, primary_key: true)
      add(:title, :string)
      add(:sub_title, :string)
      add(:description, :string)
      add(:sku, :string)
      add(:price, Money.Ecto.Composite.Type)

      timestamps()

      add(:image_id, references(:catalog_images, on_delete: :nothing))
      add(:primary_image_id, references(:catalog_images, on_delete: :nothing))
    end

    alter table(:catalog_metas) do
      add(:product_id, references(:catalog_products, on_delete: :nothing))
    end
  end
end

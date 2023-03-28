defmodule ExCatalog.Repo.Migrations.AddProductCategoriesTable do
  use Ecto.Migration

  def change do
    key_type = Application.get_env(:ex_catalog, :key_type, :integer)

    create table(:catalog_product_categories, primary_key: false) do
      add(:id, key_type, primary_key: true)
      add(:category_id, references(:catalog_categories, on_delete: :nothing))
      add(:product_id, references(:catalog_products, on_delete: :nothing))
    end
  end
end

defmodule ExCatalog.Repo.Migrations.AddCategoriesTable do
  use Ecto.Migration

  def change do
    key_type = Application.get_env(:ex_catalog, :key_type, :integer)

    create table(:catalog_categories, primary_key: false) do
      add(:id, key_type, primary_key: true)
      add(:title, :string)
      add(:description, :string)
      add(:sort_order, :integer)
      add(:slug, :string, null: false)
    end
  end
end

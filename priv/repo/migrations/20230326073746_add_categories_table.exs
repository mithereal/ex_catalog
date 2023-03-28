defmodule ExCatalog.Repo.Migrations.AddCategoriesTable do
  use Ecto.Migration

  def change do
    key_type = ExCatalog.Config.key_type(:migration)

    create table(:catalog_categories, primary_key: false) do
      add(:id, key_type, primary_key: true)
      add(:title, :string)
      add(:description, :string)
      add(:sort_order, :integer)
      add(:slug, :string, null: false)
    end
  end
end

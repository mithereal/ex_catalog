defmodule ExCatalog.Repo.Migrations.AddCategoriesTable do
  use Ecto.Migration

  def change do
    create table(:catalog_categories) do
      add(:title, :string)
      add(:description, :string)
      add(:sort_order, :integer)
      add(:slug, :string, null: false)
    end
  end
end

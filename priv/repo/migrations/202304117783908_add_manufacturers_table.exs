defmodule ExCatalog.Repo.Migrations.ManufacturersTable do
  use Ecto.Migration

  def change do
    key_type = ExCatalog.Config.key_type(:migration)

    create table(:catalog_manufacturers, primary_key: false) do
      add(:id, key_type, primary_key: true)
      add(:title, :string, null: false)
      add(:description, :string, null: false)
      add(:slug, :string, null: false)

      add(:image_id, references(:catalog_images, on_delete: :nothing, type: key_type))
    end
  end
end

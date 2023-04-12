defmodule ExCatalog.Repo.Migrations.AddImagesTable do
  use Ecto.Migration

  def change do
    key_type = ExCatalog.Config.key_type(:migration)

    create table(:catalog_images, primary_key: false) do
      add(:id, key_type, primary_key: true)
      add(:title, :string)
      add(:description, :string)
      add(:path, :string)
      add(:height, :string)
      add(:width, :string)
    end

    alter table(:catalog_categories) do
      add(:image_id, references(:catalog_images, on_delete: :nothing, type: key_type))
    end
  end
end

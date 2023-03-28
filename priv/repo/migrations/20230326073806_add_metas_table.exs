defmodule ExCatalog.Repo.Migrations.AddMetasTable do
  use Ecto.Migration

  def change do
    key_type = ExCatalog.Config.key_type()

    create table(:catalog_metas, primary_key: false) do
      add(:id, key_type, primary_key: true)
      add(:key, :string)
      add(:data, :string)
    end
  end
end

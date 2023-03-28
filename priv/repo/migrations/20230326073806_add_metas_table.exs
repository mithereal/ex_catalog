defmodule ExCatalog.Repo.Migrations.AddMetasTable do
  use Ecto.Migration

  def change do
    key_type = Application.get_env(:ex_catalog, :key_type, :integer)

    create table(:catalog_metas, primary_key: false) do
      add(:id, key_type, primary_key: true)
      add(:key, :string)
      add(:data, :string)
    end
  end
end

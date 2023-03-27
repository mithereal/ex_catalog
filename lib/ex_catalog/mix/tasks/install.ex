defmodule Mix.Tasks.ExCatalog.Install do
  @moduledoc """
    After configuring your default ecto repo in `:ecto_repos`
    Run mix ExCatalog.install to generates a `setup_ExCatalog_tables` migration,
    which creates your accounts, entries, and amounts tables, as well as
    required indexes.
  """

  def run(_args) do
    dir = Application.app_dir(:ex_catalog, "/priv/")

    files = ExCatalog.Util.list_all(dir)

    for file <- files do
      [_ | t] = String.split(file, "/") |> List.last() |> String.split("_")
      filename = (["/priv/repo/migrations/#{timestamp()}"] ++ t) |> Enum.join("_")
      target = Path.join(File.cwd!(), filename)

      if !File.dir?(target) do
        File.mkdir_p("priv/repo/migrations/")
      end

      Mix.Generator.create_file(target, EEx.eval_file(file))
    end
  end

  defp timestamp do
    {{y, m, d}, {hh, mm, ss}} = :calendar.universal_time()
    "#{y}#{pad(m)}#{pad(d)}#{pad(hh)}#{pad(mm)}#{pad(ss)}"
  end

  defp pad(i) when i < 10, do: <<?0, ?0 + i>>
  defp pad(i), do: to_string(i)
end

defmodule ExCatalog.Repo do
  use Ecto.Repo,
    otp_app: :ex_catalog,
    adapter: Ecto.Adapters.Postgres

  use Paginator

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(arg, nil) do
    init(arg, [])
  end

  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
  end

  @doc """
  Empty the Database Table
  """
  def truncate(schema) do
    table_name = schema.__schema__(:source)

    query("TRUNCATE #{table_name}", [])
  end
end

defmodule ExCatalog.Repo.Null do
  use GenServer
  use Paginator

  def child_spec(init) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [init]},
      restart: :transient,
      type: :worker
    }
  end

  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: :ex_null_repo)
  end

  def init(init_arg) do
    {:ok, init_arg}
  end
end

defmodule ExCatalog.AutoSlug do
  defmacro __using__(opts) do
    quote do
      @repo ExCatalog.Config.repo()

      def get_by_slug(slug) do
        @repo.get_by(__MODULE__, slug: slug)
      end

      def get_by_slug!(slug) do
        @repo.get_by!(__MODULE__, slug: slug)
      end
    end
  end

  def get_by_slug(slug, struct \\ %{}) do
    @repo.get_by(struct, slug: slug)
  end

  def get_by_slug!(slug, struct \\ %{}) do
    @repo.get_by!(struct, slug: slug)
  end
end

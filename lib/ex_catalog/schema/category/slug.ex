defmodule ExCatalog.Category.TitleSlug do
  @moduledoc false
  use EctoAutoslugField.Slug, from: :title, to: :slug
end

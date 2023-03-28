defmodule ExCatalog.Category.TitleSlug do
  use EctoAutoslugField.Slug, from: :title, to: :slug
end

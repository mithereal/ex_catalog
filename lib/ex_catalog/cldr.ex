defmodule ExCatalog.Cldr do
  @moduledoc false
  use Cldr,
    locales: Application.compile_env(:ex_catalog, :locales, ["en"]),
    default_locale: Application.compile_env(:ex_catalog, :default_locale, "en"),
    providers: [Cldr.Number, Money]
end

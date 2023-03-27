defmodule ExCatalog.Cldr do
  use Cldr,
    locales: Application.get_env(:ex_catalog, :locales, ["en"]),
    default_locale: Application.get_env(:ex_catalog, :default_locale, "en"),
    providers: [Cldr.Number, Money]
end

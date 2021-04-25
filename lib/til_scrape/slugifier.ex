defmodule TILScrape.Slugifier do
  def slugify(title) do
    title
    |> String.downcase()
    |> String.replace(~r/[^A-Za-z0-9\s-]/, "")
    |> String.trim()
    |> String.replace(~r/(\s|-)+/, "-")
  end
end

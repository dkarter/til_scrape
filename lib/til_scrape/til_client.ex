defmodule TILScrape.TILClient do
  use Tesla

  plug(Tesla.Middleware.BaseUrl, "https://til.hashrocket.com")

  def author_tils(username) do
    "/authors/#{username}"
    |> get!()
    |> Map.get(:body)
    |> Floki.parse_document!()
    |> Floki.find("article.post")
    |> Enum.map(fn post ->
      %{
        title: title(post),
        tag: tag(post),
        datetime: datetime(post),
        markdown_link: markdown_link(post),
        original_link: original_link(post),
        content: markdown_content(post)
      }
    end)
  end

  defp title(post) do
    post |> Floki.find("h1") |> Floki.text()
  end

  defp tag(post) do
    post |> Floki.find("a.post__tag-link") |> Floki.text()
  end

  defp datetime(post) do
    post |> Floki.find("time") |> Floki.attribute("datetime") |> List.first()
  end

  defp markdown_link(post) do
    post |> Floki.find("a.post__raw-link") |> Floki.attribute("href") |> List.first()
  end

  defp original_link(post) do
    post |> Floki.find("a.post__permalink") |> Floki.attribute("href") |> List.first()
  end

  defp markdown_content(post) do
    post
    |> markdown_link()
    |> get!()
    |> Map.get(:body)
  end
end

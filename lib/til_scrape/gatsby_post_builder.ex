defmodule TilScrape.GatsbyPostBuilder do
  @moduledoc """
  Converts a TIL post into a Gatsby post
  """

  def build(post) do
    """
    #{build_frontmatter(post)}

    #{content(post)}
    """
  end

  defp build_frontmatter(post) do
    """
    ---
    slug: #{slugified_title(post.title)}
    date: #{post.datetime}
    title: "#{post.title}"
    tags: #{tag(post)}
    original_link: #{original_link(post)}
    ---
    """
  end

  defp tag(post) do
    String.replace(post.tag, "#", "")
  end

  defp original_link(post) do
    URI.merge("https://til.hashrocket.com", post.original_link)
  end

  # remove author and date from bottom
  defp content(post) do
    lines = String.split(post.content, "\n")

    lines
    |> Enum.take(length(lines) - 3)
    |> Enum.join("\n")
  end

  defp slugified_title(title) do
    title
    |> String.downcase()
    |> String.replace(~r/[^A-Za-z0-9\s-]/, "")
    |> String.replace(~r/(\s|-)+/, "-")
  end
end

defmodule TILScrape.GatsbyPostPersister do
  @moduledoc """
  Builds the paths and proper filenames to save the post in for Gatsby
  """

  @base_path "tmp/posts/"

  def persist(post, content) do
    dir = build_path(post)

    # create the directory
    File.mkdir_p!(dir)

    # download images so they are backed up
    content = download_images_and_replace_content(post, content)

    # build post file path
    file_path = Path.join([dir, "index.md"])

    # save the file
    File.write!(file_path, content)
  end

  defp download_images_and_replace_content(post, content) do
    Regex.replace(~r/!\[(.*?)\]\((.*)\)/, content, fn _, alt, url ->
      case Tesla.get(url) do
        {:ok, %Tesla.Env{body: body}} ->
          dir = build_path(post)

          filename =
            url
            |> URI.parse()
            |> Map.get(:path)
            |> Path.basename()

          file_path = Path.join([dir, filename])

          File.write!(file_path, body)

          "![#{alt}](#{filename})"

        {:error, reason} ->
          IO.inspect(post.title)
          IO.inspect(reason, label: "error downloading image #{url}")
          "![#{alt}](#{url})"
      end
    end)
  end

  defp build_path(post) do
    slug = TILScrape.Slugifier.slugify(post.title)
    Path.join([@base_path, slug])
  end
end

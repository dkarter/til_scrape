defmodule TILScrape.GatsbyPostPersister do
  @moduledoc """
  Builds the paths and proper filenames to save the post in for Gatsby
  """

  @base_path "tmp/posts/"

  def persist(post, content) do
    slug = TILScrape.Slugifier.slugify(post.title)

    dir = Path.join([@base_path, slug])

    # create the directory
    File.mkdir_p!(dir)

    # build full file path
    file_path = Path.join([dir, "index.md"])

    # save the file
    File.write!(file_path, content)
  end
end

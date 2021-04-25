defmodule TILScrape.SlugifierTest do
  use ExUnit.Case

  alias TILScrape.Slugifier

  describe "slugify/1" do
    test "returns slug version of a title, stripping any non-word characters" do
      assert Slugifier.slugify("🔐 Simple text file #encryption with Vim 🔐") ==
               "simple-text-file-encryption-with-vim"
    end
  end
end

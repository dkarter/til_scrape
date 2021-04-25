defmodule TilScrape.GatsbyPostBuilderTest do
  use ExUnit.Case

  alias TilScrape.GatsbyPostBuilder

  describe "build/1" do
    test "converts TIL post into Gatsby post" do
      post = %{
        title: "Simple text file #encryption with Vim",
        tag: "#vim",
        datetime: "2017-11-29 19:53:21Z",
        original_link: "/posts/qkoxblhqfr-simple-text-file-encryption-with-vim",
        content:
          "Quick syntax reference for #SQL directly in #psql\n\nWhenever I forget the syntax for a certain SQL command in Posgres I usually reach for [Dash](https://kapeli.com/dash) or simply search DuckDuckGo for the the specific command. That usually yields the Postgres official documentation website which is great...\r\n\r\nWouldn't it be nice though if I could stay right inside psql and get the documentation I am looking for?\r\n\r\nIt would.. and it's possible:\r\n\r\n```\r\n\\h create index\r\n```\r\n\r\n![create index screenshot](https://i.imgur.com/Nm0lY3u.png)\r\n\r\nUse `\\h` followed by the SQL command - this is not the full verbose documentation that you would find on the Postgres docs website but it's more of a syntax reference - which is most of the time what you need.\r\n\r\n\r\nIf you are not sure what to type or simply want to explore new commands try typing `\\h` without anything after it - you will see something like this:\r\n\r\n![slash h by itself screenshot](https://i.imgur.com/PRIgAm5.png)\n\ndoriankarter\nFebruary 18, 2018"
      }

      assert GatsbyPostBuilder.build(post) ==
               """
               ---
               slug: simple-text-file-encryption-with-vim
               date: 2017-11-29 19:53:21Z
               title: "Simple text file #encryption with Vim"
               tags: vim
               original_link: https://til.hashrocket.com/posts/qkoxblhqfr-simple-text-file-encryption-with-vim
               ---


               Quick syntax reference for #SQL directly in #psql\n\nWhenever I forget the syntax for a certain SQL command in Posgres I usually reach for [Dash](https://kapeli.com/dash) or simply search DuckDuckGo for the the specific command. That usually yields the Postgres official documentation website which is great...\r\n\r\nWouldn't it be nice though if I could stay right inside psql and get the documentation I am looking for?\r\n\r\nIt would.. and it's possible:\r\n\r\n```\r\n\\h create index\r\n```\r\n\r\n![create index screenshot](https://i.imgur.com/Nm0lY3u.png)\r\n\r\nUse `\\h` followed by the SQL command - this is not the full verbose documentation that you would find on the Postgres docs website but it's more of a syntax reference - which is most of the time what you need.\r\n\r\n\r\nIf you are not sure what to type or simply want to explore new commands try typing `\\h` without anything after it - you will see something like this:\r\n\r\n![slash h by itself screenshot](https://i.imgur.com/PRIgAm5.png)
               """
    end
  end
end

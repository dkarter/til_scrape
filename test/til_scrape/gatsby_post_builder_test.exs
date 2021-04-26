defmodule TILScrape.GatsbyPostBuilderTest do
  use ExUnit.Case

  alias TILScrape.GatsbyPostBuilder

  describe "build/1" do
    test "converts TIL post into Gatsby post" do
      post = %{
        title: "Simple text file #encryption with Vim",
        tag: "#vim",
        datetime: "2017-11-29 19:53:21Z",
        original_link: "/posts/qkoxblhqfr-simple-text-file-encryption-with-vim",
        content:
          "Simple text file #encryption with Vim\n\nVim provides a simple text file encryption feature. To make use of it add the following to your .vimrc:\r\n\r\n```viml\r\nset cryptmethod=blowfish2\r\n```\r\n\r\nThis will set the encryption to the strongest algorithm vim supports.\r\n\r\nNow to use it simply start editing a file with the `-x` flag:\r\n\r\n```sh\r\n$ vim -x mysecret.txt\r\n```\r\n\r\nYou will be prompted for a password, and password confirmation. After that you should be able to edit the file and save it normally.\r\n\r\nWhen you open the file again with vim (even without the `-x` flag) you will be asked to type your password to decrypt the file. If you enter the wrong password all you'll see is gibberish.\r\n\r\nThis is not the strongest encryption out there but it works and should suffice for most personal use cases.\r\n\r\nNOTE: this will not work with NeoVim.\n\ndoriankarter\nNovember 29, 2017"
      }

      assert GatsbyPostBuilder.build(post) ==
               """
               ---
               slug: simple-text-file-encryption-with-vim
               date: 2017-11-29 19:53:21Z
               title: "Simple text file #encryption with Vim"
               tags: vim
               canonical: https://til.hashrocket.com/posts/qkoxblhqfr-simple-text-file-encryption-with-vim
               ---


               Vim provides a simple text file encryption feature. To make use of it add the following to your .vimrc:\r\n\r\n```viml\r\nset cryptmethod=blowfish2\r\n```\r\n\r\nThis will set the encryption to the strongest algorithm vim supports.\r\n\r\nNow to use it simply start editing a file with the `-x` flag:\r\n\r\n```sh\r\n$ vim -x mysecret.txt\r\n```\r\n\r\nYou will be prompted for a password, and password confirmation. After that you should be able to edit the file and save it normally.\r\n\r\nWhen you open the file again with vim (even without the `-x` flag) you will be asked to type your password to decrypt the file. If you enter the wrong password all you'll see is gibberish.\r\n\r\nThis is not the strongest encryption out there but it works and should suffice for most personal use cases.\r\n\r\nNOTE: this will not work with NeoVim.
               """
    end
  end
end

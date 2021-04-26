defmodule TILScrape do
  @author "doriankarter"

  def run do
    @author
    |> TILScrape.TILClient.author_tils()
    |> Enum.each(fn post ->
      content = TILScrape.GatsbyPostBuilder.build(post)
      TILScrape.GatsbyPostPersister.persist(post, content)
    end)
  end
end

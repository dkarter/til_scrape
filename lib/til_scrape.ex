defmodule TILScrape do
  alias TILScrape.TILClient

  @author "doriankarter"

  def run do
    @author
    |> TILClient.author_tils()
  end
end

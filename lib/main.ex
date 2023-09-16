defmodule Main do
  def start do
    # Get firsd page html body
    {:ok, firstPBody} = Pokemons.WebScraper.get_html()

    # Extract all neccessary firsd page data
    firstCompleteData = Pokemons.Parser.parse(firstPBody)

    # Get number of pages
    {:ok, pageNumber} = Pokemons.Parser.get_number_of_pages(firstPBody)

    # Get bodies rest of the pages
    completeData = start_parsing({2, pageNumber + 1})

    # Save to .json file
    JsonMeneger.convert_and_write(firstCompleteData ++ completeData)
    :ok
  end

  def start_parsing({pageNumber, maxPageNumber}) when pageNumber == maxPageNumber do
    []
  end

  def start_parsing({pageNumber, maxPageNumber}) do
    IO.puts("Successfully page nr.: #{pageNumber}")

    # Get html body nr. pageNumber
    {:ok, body} = Pokemons.WebScraper.get_html(pageNumber)

    # Extract all neccessary pageNumber page data
    [Pokemons.Parser.parse(body) | start_parsing({pageNumber + 1, maxPageNumber})]
  end
end

#  Main.start()

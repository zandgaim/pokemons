defmodule Pokemons.Parser do
  def parse(data) do
    matchingElements = Floki.find(data, "li[class*='post-']")
    mapList = data_constructor(matchingElements)
  end

  defp data_constructor([]) do
    []
  end

  defp data_constructor([el | rest]) do
    # Extract and clean product names
    productName =
      Floki.find(el, "h2.woocommerce-loop-product__title")
      |> Enum.map(&Floki.text/1)
      |> Enum.map(&String.trim/1)

    # Extract and clean product prices
    productPrice =
      Floki.find(el, "span.price")
      |> Enum.map(&Floki.text/1)
      |> Enum.map(&String.trim/1)

    # Extract and clean product ids
    productId =
      Floki.find(el, "a[data-product_id]")
      |> Floki.attribute("data-product_id")

    # Construct a map for the current product and add it to the list
    itemMap = %{
      name: hd(productName),
      price: hd(productPrice),
      id: hd(productId)
    }

    [itemMap | data_constructor(rest)]
  end

  def get_number_of_pages(data) do
    # page_count_element = Floki.find(data, ".woocommerce-pagination")
    pageCountElement =
      Floki.find(
        data,
        "nav.woocommerce-pagination ul.page-numbers li:nth-last-child(-n+2) a.page-numbers"
      )

    lastPageNumber =
      pageCountElement
      |> Enum.map(&Floki.find(&1, "a[class='page-numbers']"))
      |> Enum.map(&Floki.text(&1))
      |> hd()
      |> String.to_integer()

    case is_integer(lastPageNumber) do
      true ->
        {:ok, lastPageNumber}

      false ->
        :error
    end
  end
end

# Crawly.Engine.start_spider(Pokemons.Spiderzaur)
# Crawly.Engine.stop_spider(Pokemons.Spiderzaur)

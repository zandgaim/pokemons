defmodule Pokemons.WebScraper do
  import ExRated

  use HTTPoison.Base

  @url "https://scrapeme.live/shop/"
  @user_agent "WebScraper/1.0"

  def get_html() do
    get_html_by_url(@url)
  end

  def get_html(pageNumber) do
    url = @url <> "page/" <> Integer.to_string(pageNumber) <> "/"
    get_html_by_url(url)
  end

  def get_html_by_url(url) do
    case HTTPoison.get!(url) do
      %HTTPoison.Response{status_code: 200, body: body} ->
        {:ok, parsedBody} = Floki.parse_document(body)

      %HTTPoison.Response{status_code: status_code} ->
        {:error, "Request failed with status code #{status_code}"}

      reason ->
        {:error, "Request failed with reason: #{inspect(reason)}"}
    end
  end
end

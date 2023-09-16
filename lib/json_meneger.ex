defmodule JsonMeneger do
  def convert_and_write(data) do
    json = Jason.encode!(data, pretty: true)
    write_to_disc(json)
  end

  def write_to_disc(json) do
    file_path = "tmp/pokemon_data.json"

    timestamp =
      :erlang.timestamp()
      |> elem(1)
      |> Integer.to_string()
      |> String.replace("T", "T", global: false)

    file_name = "tmp/pokemon_data_#{timestamp}.json"
    File.write!(file_name, json)
  end
end

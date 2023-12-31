defmodule Pokemons.MixProject do
  use Mix.Project

  def project do
    [
      app: :pokemons,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :crawly]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:crawly, "~> 0.13.0"},
      {:floki, "~> 0.26.0"},
      {:jason, "~> 1.2"},
      {:httpoison, "~> 1.8"},
      {:ex_rated, "~> 2.0"}
    ]
  end
end

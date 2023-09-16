defmodule PokemonsTest do
  use ExUnit.Case
  doctest Pokemons

  test "greets the world" do
    assert Pokemons.hello() == :world
  end
end

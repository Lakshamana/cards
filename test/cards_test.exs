defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck creates unique cards" do
    deck = Cards.create_deck()
    assert deck == Enum.uniq(deck)
  end
end

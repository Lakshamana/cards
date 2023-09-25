defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck creates unique cards" do
    deck = Cards.create_deck()
    assert deck == Enum.uniq(deck)
  end

  test "create_deck creates 52 cards" do
    deck = Cards.create_deck(52)
    assert length(deck) == 52
  end

  test "contains?/2 returns true if the deck contains the card, otherwise false" do
    :rand.seed(:exsplus, {1, 2, 3})
    deck = Cards.create_deck()

    assert Cards.contains?(deck, {"Clubs", "Seven"})
    refute Cards.contains?(deck, {"Clubs", "King"})
  end
end

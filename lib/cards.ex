defmodule Cards do
  @moduledoc """
  Documentation for `Cards`.
  """

  @doc """
  Hello world.

  """
  def get_cards do
    ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
  end

  def get_suits do
    ["Spades", "Hearts", "Clubs", "Diamonds"]
  end

  defp create_deck_r(_, 0), do: []

  defp create_deck_r(l, n) do
    choice = {
      hd(Enum.shuffle(get_suits())),
      hd(Enum.shuffle(get_cards()))
    }

    case Enum.member?(l, choice) do
      true -> create_deck_r(l, n)
      _ -> [choice | create_deck_r(l, n - 1)]
    end
  end

  def contains(deck, card), do: card in deck

  def create_deck(n \\ 9), do: create_deck_r([], n)
end

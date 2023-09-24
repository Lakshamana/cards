defmodule Cards do
  @moduledoc """
  Documentation for `Cards`.
  """

  @doc """
  Returns a list of card values.

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

  def contains?(deck, card), do: Enum.member?(deck, card)

  def create_deck(n \\ 9), do: create_deck_r([], n)

  def deal(deck, size) do
    { hand, rest } = Enum.split(deck, size)

    %{ hand: hand, rest: rest }
  end

  def save(deck, filename \\ "./fixtures/deck.txt") do
    File.write(Path.expand(filename), :erlang.term_to_binary(deck))
  end

  def load(filename \\ "./fixtures/deck.txt") do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, reason} -> "Error on loading deck: #{inspect reason}"
    end
  end
end

defmodule Cards do
  @moduledoc """
  Provides functions for creating and manipulating a deck of cards.
  """

  @doc """
  Returns a list of card values.
  """
  @spec get_values() :: [String.t]
  def get_values do
    ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
  end

  @doc """
  Returns a list of card suits.
  """
  @spec get_suits() :: [String.t]
  def get_suits do
    ["Spades", "Hearts", "Clubs", "Diamonds"]
  end

  defp create_deck_r(l, n) when n == 0, do: l

  defp create_deck_r(l, n) do
    choice = {
      hd(Enum.shuffle(get_suits())),
      hd(Enum.shuffle(get_values()))
    }

    case contains?(l, choice) do
      true -> create_deck_r(l, n)
      _ -> create_deck_r([choice | l], n - 1)
    end
  end


  @doc """
  Returns true if the deck contains the card, false otherwise.

  ## Parameters

    - deck: the deck of cards to check
    - card: the card to check for

  ## Examples

      iex> :rand.seed(:exsplus, {1, 2, 3})
      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, {"Hearts", "Eight"})
      true
  """
  @spec contains?([{String.t, String.t}], {String.t, String.t}) :: boolean
  def contains?(deck, card), do: Enum.member?(deck, card)

  @doc """
  Returns a new deck of random, unique cards.

  ## Parameters

    - n: number of cards in the deck, defaults to 18

  ## Examples

      iex> :rand.seed(:exsplus, {1, 2, 3})
      iex> deck = Cards.create_deck
      iex> deck
      [
        {"Hearts", "Nine"},
        {"Clubs", "Five"},
        {"Diamonds", "Jack"},
        {"Hearts", "Eight"},
        {"Diamonds", "Six"},
        {"Diamonds", "Eight"},
        {"Hearts", "Five"},
        {"Spades", "Queen"},
        {"Clubs", "Seven"},
        {"Spades", "Five"},
        {"Clubs", "Queen"},
        {"Diamonds", "Seven"},
        {"Spades", "Ten"},
        {"Diamonds", "King"},
        {"Clubs", "Four"},
        {"Hearts", "Ace"},
        {"Spades", "Seven"},
        {"Hearts", "King"}
      ]
  """
  @spec create_deck(integer) :: [{String.t, String.t}]
    
  def create_deck(n \\ 18), do: create_deck_r([], n)

  @doc """
  Splits the deck into a hand and the rest (remainder) of the deck.

  ## Parameters

    - deck: The deck to split
    - size: The number of cards to deal

  ## Examples

      iex> :rand.seed(:exsplus, {1, 2, 3})
      iex> deck = Cards.create_deck
      iex> { hand, _ } = Cards.deal(deck, 9)
      iex> hand
      [
        {"Hearts", "Nine"},
        {"Clubs", "Five"},
        {"Diamonds", "Jack"},
        {"Hearts", "Eight"},
        {"Diamonds", "Six"},
        {"Diamonds", "Eight"},
        {"Hearts", "Five"},
        {"Spades", "Queen"},
        {"Clubs", "Seven"}
      ]
  """
  @spec deal([{String.t, String.t}], integer) :: { [{String.t, String.t}], [{String.t, String.t}] }
  def deal(deck, size), do: Enum.split(deck, size)

  @doc """
  Saves the deck to a file.

  ## Parameters

    - deck: The deck to save
    - filename: The name of the file to save the deck to. Defaults to "./fixtures/deck.txt"

  ## Examples

      iex> :rand.seed(:exsplus, {1, 2, 3})
      iex> deck = Cards.create_deck
      iex> Cards.save(deck)
      :ok
  """
  @spec save([{String.t, String.t}], String.t) :: :ok
  def save(deck, filename \\ "./fixtures/deck.txt") do
    File.write(Path.expand(filename), :erlang.term_to_binary(deck))
  end

  @doc """
  Loads the deck from a file. Returns the deck or an error message.

  ## Parameters

    - filename: The name of the file to load the deck from. Defaults to "./fixtures/deck.txt"

  ## Examples

      iex> Cards.load("./fixtures/deck.txt")
      [
        {"Hearts", "Nine"},
        {"Clubs", "Five"},
        {"Diamonds", "Jack"},
        {"Hearts", "Eight"},
        {"Diamonds", "Six"},
        {"Diamonds", "Eight"},
        {"Hearts", "Five"},
        {"Spades", "Queen"},
        {"Clubs", "Seven"},
        {"Spades", "Five"},
        {"Clubs", "Queen"},
        {"Diamonds", "Seven"},
        {"Spades", "Ten"},
        {"Diamonds", "King"},
        {"Clubs", "Four"},
        {"Hearts", "Ace"},
        {"Spades", "Seven"},
        {"Hearts", "King"}
      ]

      # If file doesn't exist:

      iex> Cards.load("path/to/file/that/doesnt/exist")
      "This file doesn't exist"
  """
  @spec load(String.t) :: [{String.t, String.t}] | String.t
  def load(filename \\ "./fixtures/deck.txt") do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _reason} -> "This file doesn't exist"
    end
  end

  @doc """
  Creates a hand of cards from a 18-card deck, of the specified size, which defaults to 9.
  It relies on create_deck/1 to create the deck and
    deal/2 to split the deck into a hand and the remainder of the deck.

  ## Parameters

    - hand_size: The number of cards to deal. Defaults to 9.

  ## Examples

      iex> :rand.seed(:exsplus, {1, 2, 3})
      iex> {hand, _} = Cards.create_hand()
      iex> hand
      [
        {"Hearts", "Nine"},
        {"Clubs", "Five"},
        {"Diamonds", "Jack"},
        {"Hearts", "Eight"},
        {"Diamonds", "Six"},
        {"Diamonds", "Eight"},
        {"Hearts", "Five"},
        {"Spades", "Queen"},
        {"Clubs", "Seven"}
      ]
  """
  @spec create_hand(integer) :: { [{String.t, String.t}], [{String.t, String.t}] }
  def create_hand(hand_size \\ 9), do: Cards.create_deck |> Cards.deal(hand_size)
end

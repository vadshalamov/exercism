defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number), do: do_verse(number)

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range) do
    range
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end

  def lyrics(), do: lyrics(99..0)

  defp do_verse(number), do:
    build_first_line(number) <> "\n" <> build_second_line(number) <> "\n"

  defp build_first_line(0), do: "No more bottles of beer on the wall, no more bottles of beer."
  defp build_first_line(number), do:
    "#{bottles_number(number)} of beer on the wall, #{bottles_number(number)} of beer."

  defp build_second_line(1), do: "Take it down and pass it around, no more bottles of beer on the wall."
  defp build_second_line(0), do: "Go to the store and buy some more, 99 bottles of beer on the wall."
  defp build_second_line(number), do:
    "Take one down and pass it around, #{bottles_number(number - 1)} of beer on the wall."

  defp bottles_number(1), do: "1 bottle"
  defp bottles_number(number), do: "#{number} bottles"
end

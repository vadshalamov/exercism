defmodule Roman do
  @arabic_as_roman [
    {1000, "M"},
    {900, "CM"},
    {500, "D"},
    {400, "CD"},
    {100, "C"},
    {90, "XC"},
    {50, "L"},
    {40, "XL"},
    {10, "X"},
    {9, "IX"},
    {5, "V"},
    {4, "IV"},
    {1, "I"}
  ]
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t()
  def numerals(number) do
    convert_to_roman(@arabic_as_roman, number)
  end

  defp convert_to_roman([], _), do: ""
  defp convert_to_roman([{arabic, roman} | _] = arabic_as_roman, number) when number >= arabic,
    do: roman <> convert_to_roman(arabic_as_roman, number - arabic)

  defp convert_to_roman([_ | tail], number), do: convert_to_roman(tail, number)
end

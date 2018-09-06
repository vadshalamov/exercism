defmodule Roman do
  @number_as_roman [
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
    do_numerals(@number_as_roman, number)
  end

  defp do_numerals([], _), do: ""
  defp do_numerals([{arabic, roman} | _] = numbers, number) when number >= arabic,
    do: roman <> do_numerals(numbers, number - arabic)

  defp do_numerals([_ | tail], number), do: do_numerals(tail, number)
end

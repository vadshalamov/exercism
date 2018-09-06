defmodule Roman do
  @number_as_roman %{
    1    => "I",
    4    => "IV",
    5    => "V",
    9    => "IX",
    10   => "X",
    40   => "XL",
    50   => "L",
    90   => "XC",
    100  => "C",
    400  => "CD",
    500  => "D",
    900  => "CM",
    1000 => "M"
  }
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t()
  def numerals(number) do
    @number_as_roman
    |> Map.keys()
    |> Enum.sort()
    |> Enum.reverse()
    |> do_numerals(number)
  end

  defp do_numerals([], _), do: ""
  defp do_numerals([head | tail] = numbers, value) when value >= head,
    do: @number_as_roman[head] <> do_numerals(numbers, value - head)

  defp do_numerals([_ | tail], value), do: do_numerals(tail, value)
end

defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.to_charlist
    |> Enum.map(&rotate_char(&1, shift))
    |> List.to_string
  end

  def rotate_char(char, shift) when char in ?a..?z, do: do_shift(char, shift, ?a)
  def rotate_char(char, shift) when char in ?A..?Z, do: do_shift(char, shift, ?A)
  def rotate_char(char, _), do: char

  def do_shift(char, shift, lower_range_char) do
    lower_range_char + rem((char - lower_range_char) + shift, 26)
  end
end

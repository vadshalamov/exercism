defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase()
    |> String.split([" ", "_"])
    |> Enum.map(&normalize_word/1)
    |> Enum.reduce(%{}, &increment_word_counter/2)
  end

  defp increment_word_counter("", acc), do: acc
  defp increment_word_counter(word, acc), do: Map.update(acc, word, 1, &(&1 + 1))

  defp normalize_word(word) do
    word
    |> String.split("", trim: true)
    |> Enum.reduce("", &filter_valid_chars/2)
  end

  defp filter_valid_chars(char, acc) do
    if valid_char?(char) do
      acc <> char
    else
      acc
    end
  end

  defp valid_char?(char), do: hyphen?(char) || letter?(char) || number?(char)

  defp letter?(char), do: String.upcase(char) != String.downcase(char)

  defp hyphen?(char), do: char == "-"

  defp number?(char), do: !match?(:error, Integer.parse(char))
end

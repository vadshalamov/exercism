defmodule Bob do
  def hey(input) do
    cond do
      silence?(input) ->
        "Fine. Be that way!"

      yell?(input) ->
        if question?(input), do: "Calm down, I know what I'm doing!", else: "Whoa, chill out!"

      question?(input) ->
        "Sure."

      true ->
        "Whatever."
    end
  end

  defp question?(input), do: String.ends_with?(input, "?")
  defp yell?(input), do: String.upcase(input) == input && (String.downcase(input) != input)
  defp silence?(input), do: String.trim(input) == ""
end

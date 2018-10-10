defmodule Markdown do
  @bold_text_prefix_regex ~r/^#{"__"}{1}/
  @bold_text_suffix_regex ~r/#{"__"}{1}$/
  @italic_text_prefix_regex ~r/^[#{"_"}{1}][^#{"_"}+]/
  @italic_text_suffix_regex ~r/[^#{"_"}{1}]/

  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(text) do
    text
    |> String.split("\n")
    |> Enum.map(&process/1)
    |> Enum.join()
    |> wrap_list_with_tags()
  end

  defp process("*" <> _ = line), do: parse_list_line(line)
  defp process("#" <> _ = line) do
   line
    |> String.split()
    |> parse_heading()
    |> enclose_with_header_tag()
  end

  defp process(paragraph) do
    paragraph
    |> String.split()
    |> join_words_with_tags()
    |> wrap_with_tag("p")
  end

  defp parse_heading([signs | line]) do
    {String.length(signs), Enum.join(line, " ")}
  end

  defp parse_list_line(line) do
    line
    |> String.trim_leading("* ")
    |> String.split()
    |> join_words_with_tags()
    |> wrap_with_tag("li")
  end

  defp wrap_with_tag(text, tag), do: "<#{tag}>" <> text <> "</#{tag}>"

  defp enclose_with_header_tag({level, line}), do: wrap_with_tag(line, "h#{level}")

  defp join_words_with_tags(words) do
    words
    |> Enum.map(&replace_word_with_tag/1)
    |> Enum.join(" ")
  end

  defp replace_word_with_tag(word) do
    word
    |> replace_prefix_with_tag()
    |> replace_suffix_with_tag()
  end

  defp replace_prefix_with_tag(word) do
    cond do
      word =~ @bold_text_prefix_regex -> String.replace(word, @bold_text_prefix_regex, "<strong>", global: false)
      word =~ @italic_text_prefix_regex -> String.replace(word, ~r/_/, "<em>", global: false)
      true -> word
    end
  end

  defp replace_suffix_with_tag(word) do
    cond do
      word =~ @bold_text_suffix_regex -> String.replace(word, @bold_text_suffix_regex, "</strong>")
      word =~ @italic_text_suffix_regex -> String.replace(word, ~r/_/, "</em>")
      true -> word
    end
  end

  defp wrap_list_with_tags(text) do
    text
    |> String.replace("<li>", "<ul>" <> "<li>", global: false)
    |> String.replace_suffix("</li>", "</li>" <> "</ul>")
  end
end

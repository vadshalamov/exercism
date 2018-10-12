defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search({}, _), do: :not_found
  def search(numbers, key) do
    first_index = 0
    last_index = tuple_size(numbers) - 1

    cond do
      key < elem(numbers, first_index) ->
        :not_found
      key > elem(numbers, last_index) ->
        :not_found
      true ->
        do_search(numbers, key, first_index, last_index)
    end
  end

  defp do_search(numbers, key, first_index, last_index) do
    search_index = trunc(first_index + (last_index - first_index) / 2)
    candidate = elem(numbers, search_index)

    check_candidate(numbers, key, candidate, search_index, first_index, last_index)
  end

  defp check_candidate(_, key, candidate, search_index, _, _) when candidate == key, do:
    {:ok, search_index}

  defp check_candidate(_, _, _, _, first_index, last_index) when first_index == last_index, do:
    :not_found

  defp check_candidate(numbers, key, candidate, search_index, first_index, _) when candidate > key, do:
    do_search(numbers, key, first_index, search_index)

  defp check_candidate(numbers, key, candidate, search_index, _, last_index) when candidate < key, do:
    do_search(numbers, key, search_index + 1, last_index)
end

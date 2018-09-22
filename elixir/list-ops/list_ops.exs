defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l), do: do_count(l)

  defp do_count([]), do: 0
  defp do_count([_ | tail]), do: do_count(tail) + 1

  @spec reverse(list) :: list
  def reverse(l), do: do_reverse(l)

  defp do_reverse([]), do: []
  defp do_reverse([a, b]), do: [b, a]
  defp do_reverse([a, b | tail]), do: do_reverse(tail, [b, a])

  defp do_reverse([], reversed), do: reversed
  defp do_reverse([head | tail], reversed), do: do_reverse(tail, [head | reversed])

  @spec map(list, (any -> any)) :: list
  def map(l, f), do: do_map(l, f)

  defp do_map([], _), do: []
  defp do_map([head | tail], f), do: [f.(head) | do_map(tail, f)]

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f), do: do_filter(l, f)

  defp do_filter([], _), do: []
  defp do_filter([head | tail], f) do
    if f.(head) == true do
      [head | do_filter(tail, f)]
    else
      do_filter(tail, f)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce(l, acc, f), do: do_reduce(l, acc, f)

  defp do_reduce([], acc, _), do: acc
  defp do_reduce([head | tail], acc, f), do: do_reduce(tail, f.(head, acc), f)

  @spec append(list, list) :: list
  def append(a, b), do: do_append(a, b)

  defp do_append([], []), do: []
  defp do_append([], [_ | _] = second), do: second
  defp do_append([_ | _] = first, []), do: first
  defp do_append([head | tail], [_ | _] = second), do: [head | do_append(tail, second)]

  @spec concat([[any]]) :: [any]
  def concat(ll), do: do_concat(ll)

  defp do_concat([]), do: []
  defp do_concat([[] | tail]), do: do_concat(tail)
  defp do_concat([[_ | _] = head | tail]), do: append(head, do_concat(tail))
end

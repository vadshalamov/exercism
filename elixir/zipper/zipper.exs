defmodule BinTree do
  import Inspect.Algebra

  @moduledoc """
  A node in a binary tree.

  `value` is the value of a node.
  `left` is the left subtree (nil if no subtree).
  `right` is the right subtree (nil if no subtree).
  """
  @type t :: %BinTree{value: any, left: BinTree.t() | nil, right: BinTree.t() | nil}
  defstruct value: nil, left: nil, right: nil

  # A custom inspect instance purely for the tests, this makes error messages
  # much more readable.
  #
  # BT[value: 3, left: BT[value: 5, right: BT[value: 6]]] becomes (3:(5::(6::)):)
  def inspect(%BinTree{value: v, left: l, right: r}, opts) do
    concat([
      "(",
      to_doc(v, opts),
      ":",
      if(l, do: to_doc(l, opts), else: ""),
      ":",
      if(r, do: to_doc(r, opts), else: ""),
      ")"
    ])
  end
end

defmodule Zipper do
  @type t :: %Zipper{focus: BinTree.t() | nil, trail: List.t()}
  defstruct focus: nil, trail: []

  @doc """
  Get a zipper focused on the root focus.
  """
  @spec from_tree(BT.t()) :: Z.t()
  def from_tree(%BinTree{} = bintree), do: %Zipper{focus: bintree}

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Z.t()) :: BT.t()
  def to_tree(%Zipper{trail: [], focus: focus}), do: focus
  def to_tree(%Zipper{} = zipper), do: zipper |> up() |> to_tree()

  @doc """
  Get the value of the focus focus.
  """
  @spec value(Z.t()) :: any
  def value(%Zipper{focus: %BinTree{value: value}}), do: value

  @doc """
  Get the left child of the focus focus, if any.
  """
  @spec left(Z.t()) :: Z.t() | nil
  # def left(%Zipper{focus: nil}), do: nil
  def left(%Zipper{focus: %BinTree{left: nil}}), do: nil
  def left(%Zipper{focus: %BinTree{left: %BinTree{} = left} = focus, trail: trail}), do:
    %Zipper{focus: left, trail: [{:left, focus} | trail]}

  @doc """
  Get the right child of the focus focus, if any.
  """
  @spec right(Z.t()) :: Z.t() | nil
  def right(%Zipper{focus: %BinTree{right: nil}}), do: nil
  def right(%Zipper{focus: %BinTree{right: %BinTree{} = right} = focus, trail: trail}), do:
    %Zipper{focus: right, trail: [{:right, focus} | trail]}

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Z.t()) :: Z.t()
  def up(%Zipper{trail: []}), do: nil
  def up(%Zipper{trail: [head | tail], focus: focus}), do: do_up(head, tail, focus)

  def do_up({:left, bintree}, trail, focus), do:
    %Zipper{focus: %{bintree | left: focus}, trail: trail}

  def do_up({:right, bintree}, trail, focus), do:
    %Zipper{focus: %{bintree | right: focus}, trail: trail}

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Z.t(), any) :: Z.t()
  def set_value(%Zipper{focus: focus} = zipper, value), do:
    %{zipper | focus: %{focus | value: value}}

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Z.t(), BT.t()) :: Z.t()
  def set_left(%Zipper{focus: focus} = zipper, left), do:
    %{zipper | focus: %{focus | left: left}}

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Z.t(), BT.t()) :: Z.t()
  def set_right(%Zipper{focus: focus} = zipper, right), do:
    %{zipper | focus: %{focus | right: right}}
end

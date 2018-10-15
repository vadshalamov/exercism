defmodule Robot do
  defstruct [
    position: {0, 0},
    direction: :north
  ]
end

defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create, do: %Robot{}
  def create(direction, position) do
    with :ok <- validate_direction(direction),
         :ok <- validate_position(position) do
      %Robot{direction: direction, position: position}
    end
  end

  defp validate_direction(:north), do: :ok
  defp validate_direction(:east), do: :ok
  defp validate_direction(:south), do: :ok
  defp validate_direction(:west), do: :ok
  defp validate_direction(_), do: {:error, "invalid direction"}

  defp validate_position({x, y}) do
    if is_integer(x) && is_integer(y) do
      :ok
    else
      {:error, "invalid position"}
    end
  end
  defp validate_position(_), do: {:error, "invalid position"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    instructions_steps = String.split(instructions, "", trim: true)

    with :ok <- validate_instructions(instructions_steps) do
      Enum.reduce(instructions_steps, robot, &move/2)
    end
  end

  defp validate_instructions(instructions_steps) do
    if Enum.any?(instructions_steps, &invalid_instruction?/1) do
      {:error, "invalid instruction"}
    else
      :ok
    end
  end

  defp invalid_instruction?("L"), do: false
  defp invalid_instruction?("R"), do: false
  defp invalid_instruction?("A"), do: false
  defp invalid_instruction?(_), do: true

  defp move("L", %Robot{direction: direction} = robot), do:
    %{robot | direction: turn_left(direction)}

  defp move("R", %Robot{direction: direction} = robot), do:
    %{robot | direction: turn_right(direction)}

  defp move("A", %Robot{direction: direction, position: position} = robot), do:
    %{robot | position: advance(direction, position)}

  defp turn_left(:north), do: :west
  defp turn_left(:east), do: :north
  defp turn_left(:south), do: :east
  defp turn_left(:west), do: :south

  defp turn_right(:north), do: :east
  defp turn_right(:east), do: :south
  defp turn_right(:south), do: :west
  defp turn_right(:west), do: :north

  defp advance(:north, {x, y}), do: {x, y + 1}
  defp advance(:east, {x, y}), do: {x + 1, y}
  defp advance(:south, {x, y}), do: {x, y - 1}
  defp advance(:west, {x, y}), do: {x - 1, y}

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(%Robot{direction: direction}), do: direction

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(%Robot{position: position}), do: position
end

defmodule AdventOfCode.Day01 do
  @right_bearings %{north: :east, east: :south, south: :west, west: :north }
  @left_bearings %{east: :north, south: :east, west: :south, north: :west}

  def solve do
    {part01, part02} =
      read_file()
      |> parse_inputs()
      |> handle_instructions()

    IO.inspect "Part 01: #{inspect(part01)}"
    IO.inspect "Part 02: #{inspect(part02)}"
    nil
  end


  defp distance_from_dropzone({x,y}), do: abs(x) + abs(y)

  defp find_first_visited_twice(positions, visited \\ [])
  defp find_first_visited_twice([current | rest], visited) do
    case current in visited do
      true  -> current
      false -> find_first_visited_twice(rest, [current|visited])
    end
  end

  defp handle_instructions(directions, bearing \\ :north, pos \\ [{0, 0}])
  defp handle_instructions([], _, [point | _] = positions) do
    part01 = distance_from_dropzone(point)
    part02 = positions |> Enum.reverse() |> find_first_visited_twice() |> distance_from_dropzone()

    {part01, part02}
  end
  defp handle_instructions([{dir, num} | rest], bearing, pos) do
    new_bearing = turn(dir, bearing)
    new_pos = move(num, pos, new_bearing)
    handle_instructions(rest, new_bearing, new_pos)
  end

  defp move(0, positions, _), do: positions
  defp move(n, [{x, y}|_] = p, :north = b), do: move(n-1, [{x, y + 1}|p], b)
  defp move(n, [{x, y}|_] = p, :east = b),  do: move(n-1, [{x + 1, y}|p], b)
  defp move(n, [{x, y}|_] = p, :south = b), do: move(n-1, [{x, y - 1}|p], b)
  defp move(n, [{x, y}|_] = p, :west = b),  do: move(n-1, [{x - 1, y}|p], b)

  defp turn(?R, bearing), do: @right_bearings[bearing]
  defp turn(?L, bearing), do: @left_bearings[bearing]

  defp read_file do
    case File.read("lib/day01/input.txt") do
      {:ok, content} -> content |> String.strip |>  String.split(", ")
      {:error, _} -> raise "Input file is missing"
    end
  end

  defp parse_inputs(input) do
    input |> Enum.map(&parse_input/1)
  end

  defp parse_input(<< dir :: size(8), length :: binary>>) do
    {dir, parse_int(length)}
  end

  defp parse_int(str) do
    {int, ""} = Integer.parse(str)
    int
  end
end

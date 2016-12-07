defmodule AdventOfCode.Day01 do
  def solve do
    {part01, part02} =
      read_file()
      |> parse_inputs()
      |> move()

    IO.inspect "Part 01: #{inspect(part01)}"
    IO.inspect "Part 02: #{inspect(part02)}"
    nil
  end

  def find_first_visited_twice(_positions) do
    {0, 0}
  end

  defp move(directions, current_direction \\ :north, positions \\ [{0, 0}])

  defp move([], _, [{x, y} | _] = positions) do
    part01 = abs(x) + abs(y)
    part02 = find_first_visited_twice(positions)

    {part01, part02}
  end

  defp move([{?L, num} | rest], :north, [{x, y} | _] = pos) do
    move(rest, :west, [{x - num, y} | pos])
  end
  defp move([{?L, num} | rest], :east, [{x, y} | _] = pos) do
    move(rest, :north, [{x, y + num} | pos])
  end
  defp move([{?L, num} | rest], :south, [{x, y} | _] = pos) do
    move(rest, :east, [{x + num, y} | pos])
  end
  defp move([{?L, num} | rest], :west, [{x, y} | _] = pos) do
    move(rest, :south, [{x, y - num} | pos])
  end

  defp move([{?R, num} | rest], :north, [{x, y} | _] = pos) do
    move(rest, :east, [{x + num, y} | pos])
  end
  defp move([{?R, num} | rest], :east, [{x, y} | _] = pos) do
    move(rest, :south, [{x, y - num} | pos])
  end
  defp move([{?R, num} | rest], :south, [{x, y} | _] = pos) do
    move(rest, :west, [{x - num, y} | pos])
  end
  defp move([{?R, num} | rest], :west, [{x, y} | _] = pos) do
    move(rest, :north, [{x, y + num} | pos])
  end

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

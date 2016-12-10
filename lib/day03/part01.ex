defmodule AdventOfCode.Day03.Part01 do
  def solve do
    read_file
    |> Stream.map(&String.split/1)
    |> Stream.map(fn([x, y, z]) ->
      {String.to_integer(x), String.to_integer(y), String.to_integer(z)}
    end)
    |> Enum.count(fn({x, y, z}) ->
      x + y > z && x + z > y && y + z > x
    end)
  end

  defp read_file, do: File.read!("lib/day03/input.txt") |> String.trim |> String.split("\n")
end

defmodule AdventOfCode.Day02 do
  @keypad %{
    {0,0} => 1, {1, 0} => 2, {2, 0} => 3,
    {0,1} => 4, {1, 1} => 5, {2, 1} => 5,
    {0,2} => 7, {1, 2} => 8, {2, 2} => 9
  }

  def solve do
    read_file
    |> Enum.map(&find_key/1)
    |> Enum.join()
    |> IO.puts
  end

  def find_key(directions, pos \\ {1, 1})
  def find_key("", pos), do: @keypad[pos]
  def find_key("U" <> rest, {x, y}) when y > 0 do
    find_key(rest, {x, y - 1})
  end
  def find_key("R" <> rest, {x, y}) when x < 2 do
    find_key(rest, {x + 1, y})
  end
  def find_key("D" <> rest, {x, y}) when y < 2 do
    find_key(rest, {x, y + 1})
  end
  def find_key("L" <> rest, {x, y}) when x > 0 do
    find_key(rest, {x - 1, y})
  end
  def find_key(<< _skip :: size(8), rest :: binary >>, pos) do
    find_key(rest, pos)
  end

  defp read_file do
    case File.read("lib/day02/input.txt") do
      {:ok, content} -> content |> String.trim |> String.split("\n")
      {:error, _} -> raise "Input file is missing"
    end
  end
end

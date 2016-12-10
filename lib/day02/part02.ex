defmodule AdventOfCode.Day02.Part02 do
  @keypad %{
    {0, 2} =>  1,
    {-1, 1} => 2,  {0, 1} =>  3, {1, 1} => 4,
    {-2, 0} => 5,  {-1, 0} => 6, {0, 0} => 7, {1, 0} => 8, {2, 0} => 9,
    {-1, -1} => "A", {0, -1} => "B", {1, -1} => "C",
    {0, -2} => "D"
  }

  def solve do
    read_file
    |> Enum.map(&find_key/1)
    |> Enum.join()
    |> IO.puts
  end

  defp find_key(directions, pos \\ {-2, 0})
  defp find_key("", pos), do: @keypad[pos]
  defp find_key(<< dir :: size(8), rest :: binary >>, pos) do
    find_key(rest, move(dir, pos))
  end

  defp move(?U, {x, y} = current) do
    new_pos({x, y + 1}, current)
  end
  defp move(?R, {x, y} = current) do
    new_pos({x + 1, y}, current)
  end
  defp move(?D, {x, y} = current) do
    new_pos({x, y - 1}, current)
  end
  defp move(?L, {x, y} = current) do
    new_pos({x - 1, y}, current)
  end

  defp new_pos(new, old) do
    case Map.has_key?(@keypad, new) do
      true  -> new
      false -> old
    end
  end

  defp read_file do
    case File.read("lib/day02/input.txt") do
      {:ok, content} -> content |> String.trim |> String.split("\n")
      {:error, _} -> raise "Input file is missing"
    end
  end
end

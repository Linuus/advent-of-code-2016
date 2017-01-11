defmodule AdventOfCode.Day06.Part02 do
  def solve do
    read_file()
    |> Enum.map(&String.graphemes/1)
    |> List.zip
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&most_used/1)
    |> Enum.join()
  end

  defp most_used(list) do
    {char, _} =
      list
      |> Enum.group_by(&(&1))
      |> Enum.min_by(fn({_, v})-> length(v) end)

    char
  end

  defp read_file do
    File.read!("lib/day06/input.txt")
    |> String.trim
    |> String.split("\n")
  end
end

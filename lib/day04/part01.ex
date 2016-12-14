defmodule AdventOfCode.Day04.Part01 do
  def solve do
    read_file
    |> Stream.map(&parse/1)
    |> Enum.reduce(0, &sum_if_valid_room/2)
  end

  defp parse(room) do
    ~r/([a-z-]+)([0-9]+)\[([a-z]+)\]/
    |> Regex.scan(room, capture: :all_but_first)
    |> hd()
  end

  defp sum_if_valid_room([string, id, checksum], sum) do
    string |> calculate_checksum() |> sum_if_valid(checksum, id, sum)
  end

  defp sum_if_valid(checksum, checksum, id, sum), do: sum + String.to_integer(id)
  defp sum_if_valid(_, _, _, sum), do: sum

  defp calculate_checksum(string) do
    string
    |> String.replace("-", "")
    |> String.graphemes
    |> Enum.sort
    |> Enum.chunk_by(&(&1))
    |> Enum.sort_by(&length/1, &>=/2)
    |> List.flatten
    |> Enum.uniq
    |> Enum.take(5)
    |> Enum.join()
  end

  defp read_file, do: File.read!("lib/day04/input.txt") |> String.trim |> String.split("\n")
end

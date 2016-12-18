defmodule AdventOfCode.Day04.Part02 do
  def solve do
    read_file
    |> Stream.map(&parse/1)
    |> Stream.filter(&valid_room?/1)
    |> Stream.map(&decrypt/1)
    |> Enum.find(fn({_id, str})->
      Regex.match?(~r/north/, str)
    end)
  end

  defp parse(room) do
    ~r/([a-z-]+)([0-9]+)\[([a-z]+)\]/
    |> Regex.scan(room, capture: :all_but_first)
    |> hd()
  end

  defp valid_room?([string, _id, checksum]) do
    calculate_checksum(string) == checksum
  end

  defp decrypt([string, id, _]) do
    id = String.to_integer(id)
    decrypted_string =
      string
      |> String.to_charlist()
      |> Enum.map(&shift(&1, id))
      |> to_string()
    {id, decrypted_string}
  end

  defp shift(?-, _), do: " "
  defp shift(char, id) do
    rem((char - ?a) + id, 26) + ?a
  end

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

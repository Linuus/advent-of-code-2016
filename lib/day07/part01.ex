defmodule AdventOfCode.Day07.Part01 do
  def solve do
    read_file |> Enum.filter(&valid?/1) |> length()
  end

  defp valid?(ip), do: valid?(ip, :out, false)

  defp valid?("", _, abba), do: abba

  defp valid?(<< a, b, b, a, rest :: binary >>, :out, _) when a != b, do: valid?(rest, :out, true)
  defp valid?(<< a, b, b, a, _rest :: binary >>, :in, _) when a != b, do: false

  defp valid?("[" <> rest, _, abba), do: valid?(rest, :in, abba)
  defp valid?("]" <> rest, _, abba), do: valid?(rest, :out, abba)

  defp valid?(<< _, rest :: binary >>, state, abba), do: valid?(rest, state, abba)

  defp read_file, do: File.read!("lib/day07/input.txt") |> String.trim |> String.split("\n")
end

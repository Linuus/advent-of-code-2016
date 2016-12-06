defmodule AdventOfCode.Day01 do
  def part01 do
    move(read_file, :north, {0, 0})
  end

  defp move([], _, {x, y}), do: abs(x) + abs(y)

  defp move(["L" <> num | rest], :north, {x, y}) do
    new_x = x - parse_int(num)
    move(rest, :west, {new_x, y})
  end
  defp move(["L" <> num | rest], :east, {x, y}) do
    new_y = y + parse_int(num)
    move(rest, :north, {x, new_y})
  end
  defp move(["L" <> num | rest], :south, {x, y}) do
    new_x = x + parse_int(num)
    move(rest, :east, {new_x, y})
  end
  defp move(["L" <> num | rest], :west, {x, y}) do
    new_y = y - parse_int(num)
    move(rest, :south, {x, new_y})
  end

  defp move(["R" <> num | rest], :north, {x, y}) do
    new_x = x + parse_int(num)
    move(rest, :east, {new_x, y})
  end
  defp move(["R" <> num | rest], :east, {x, y}) do
    new_y = y - parse_int(num)
    move(rest, :south, {x, new_y})
  end
  defp move(["R" <> num | rest], :south, {x, y}) do
    new_x = x - parse_int(num)
    move(rest, :west, {new_x, y})
  end
  defp move(["R" <> num | rest], :west, {x, y}) do
    new_y = y + parse_int(num)
    move(rest, :north, {x, new_y})
  end

  defp read_file do
    case File.read("lib/day01/input.txt") do
      {:ok, content} -> content |> String.strip |>  String.split(", ")
      {:error, _} -> raise "Input file is missing"
    end
  end

  defp parse_int(str) do
    {int, ""} = Integer.parse(str)
    int
  end
end

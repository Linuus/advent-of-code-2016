defmodule AdventOfCode.Day05.Part02 do
  @input "wtnhxymk"
  @initial_pass ["_", "_", "_", "_", "_", "_", "_", "_"]
  @valid_positions '01234567'

  def solve do
    Stream.iterate(0, &(&1+1))
    |> Enum.reduce_while(@initial_pass, &check_password/2)
  end

  defp check_password(i, pass) do
    @input <> to_string(i)
    |> :erlang.md5()
    |> Base.encode16(case: :lower)
    |> add_if_valid(pass)
  end

  defp add_if_valid(<<"00000", pos :: size(8), next :: size(8), _ :: binary>> = hash, pass) when pos in @valid_positions do
    pos = [pos] |> to_string() |> String.to_integer()

    case Enum.at(pass, pos) do
      "_" -> add_to_pass(pos, next, pass)
      _   -> {:cont, pass}
    end
  end
  defp add_if_valid(hash, pass), do: {:cont, pass}

  defp add_to_pass(pos, value, pass) do
    new_pass = List.replace_at(pass, pos, value)

    case Enum.any?(new_pass, fn(x)-> x == "_" end) do
      true -> {:cont, new_pass}
      _    -> {:halt, new_pass}
    end
  end
end

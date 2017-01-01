defmodule AdventOfCode.Day05.Part01 do
  @input "wtnhxymk"

  def solve do
    Stream.iterate(0, &(&1+1))
    |> Enum.reduce_while([], &do_password/2)
    |> Enum.reverse()
  end

  defp do_password(_, pass) when length(pass) == 8, do: {:halt, pass}
  defp do_password(i, pass) do
    @input <> to_string(i)
    |> :erlang.md5()
    |> Base.encode16(case: :lower)
    |> add_if_valid(i, pass)
  end

  defp add_if_valid(<<"00000", next :: size(8), _ :: binary>>, i, pass) do
    IO.inspect i
    {:cont, [next | pass]}
  end
  defp add_if_valid(_, _, pass), do: {:cont, pass}
end

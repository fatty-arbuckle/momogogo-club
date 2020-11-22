defmodule Momogogo.Helper do
  def human_number(i) do
    i
    |> Integer.to_char_list
    |> Enum.reverse
    |> Enum.chunk_every(3, 3, [])
    |> Enum.join(",")
    |> String.reverse
  end
end

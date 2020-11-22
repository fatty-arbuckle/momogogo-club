defmodule Momogogo.Helper do
  def human_number(i) do
    i
    |> Integer.to_char_list
    |> Enum.reverse
    |> Enum.chunk_every(3, 3, [])
    |> Enum.join(",")
    |> String.reverse
  end

  def email_or_name(email, nil), do: email
  def email_or_name(_email, name), do: name

end

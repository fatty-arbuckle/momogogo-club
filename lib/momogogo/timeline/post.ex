defmodule Momogogo.Timeline.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :username, :string, default: "dummy"
    field :date, :string, default: (DateTime.utc_now
      |> DateTime.to_date
      |> Date.to_iso8601)
    field :activity, :string
    field :duration, :integer, default: 30
    field :steps, :integer, default: 30

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    attrs = update_steps(attrs)
    post
    |> cast(attrs, [:date, :activity, :duration])
    |> validate_required([:date, :activity, :duration])
    |> validate_number(:duration, greater_than: 0)
    |> update_steps()
  end

  defp update_steps(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, data: data, changes: changes} ->
        put_change(changeset, :steps, Momogogo.Steps.convert(get_activity(data, changes), get_duration(data, changes)))
      _ ->
        changeset
    end
  end

  defp get_activity(_data, %{activity: activity}), do: activity
  defp get_activity(%{activity: activity}, _changes), do: activity
  defp get_duration(_data, %{duration: duration}), do: duration
  defp get_duration(%{duration: duration}, _changes), do: duration

end

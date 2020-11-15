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
    field :steps, :integer, default: 0

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:date, :activity, :duration])
    |> validate_required([:date, :activity, :duration])
  end
end

defmodule Momogogo.Timeline.Preferences do
  use Ecto.Schema
  import Ecto.Changeset

  schema "preferences" do
    field :step_scale, :string, default: "default"
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(preferences, attrs) do
    preferences
    |> cast(attrs, [:user_id, :step_scale])
    |> validate_required([:user_id, :step_scale])
  end
end

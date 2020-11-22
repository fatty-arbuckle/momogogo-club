defmodule Momogogo.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    pow_user_fields()

    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> cast(attrs, [:name])
    |> pow_user_id_field_changeset(attrs)
    |> Pow.Ecto.Schema.Changeset.password_changeset(attrs, @pow_config)
  end

end

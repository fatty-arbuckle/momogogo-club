defmodule Momogogo.Repo.Migrations.CreatePreferences do
  use Ecto.Migration

  def change do
    create table(:preferences) do
      add :user_id, :integer
      add :step_scale, :string

      timestamps()
    end

  end
end

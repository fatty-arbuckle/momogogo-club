defmodule Momogogo.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :username, :string
      add :date, :string
      add :activity, :string
      add :duration, :integer
      add :steps, :integer

      timestamps()
    end

  end
end

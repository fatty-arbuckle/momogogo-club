defmodule Momogogo.Repo.Migrations.AddCustomUserInfo do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :name, :string, null: true
    end
  end
end

defmodule Elvenhearth.Repo.Migrations.AddCharactersTable do
  use Ecto.Migration

  def change do
    create table(:characters) do
      add :name, :string
      add :race, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
  end
end

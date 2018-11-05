defmodule Elvenhearth.Repo.Migrations.AddUniqueUsername do
  use Ecto.Migration

  def change do
    create unique_index(:users, [:username])
    create unique_index(:characters, [:race])
  end
end

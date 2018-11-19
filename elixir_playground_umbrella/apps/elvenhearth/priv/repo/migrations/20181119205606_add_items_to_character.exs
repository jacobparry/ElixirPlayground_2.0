defmodule Elvenhearth.Repo.Migrations.AddItemsToCharacter do
  use Ecto.Migration

  def change do
    alter table(:characters) do
      add :items, :map
    end
  end
end

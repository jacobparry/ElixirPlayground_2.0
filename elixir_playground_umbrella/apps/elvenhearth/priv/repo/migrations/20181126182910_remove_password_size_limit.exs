defmodule Elvenhearth.Repo.Migrations.RemovePasswordSizeLimit do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify(:password, :string, size: nil)
      add(:role, :string)
    end
  end
end

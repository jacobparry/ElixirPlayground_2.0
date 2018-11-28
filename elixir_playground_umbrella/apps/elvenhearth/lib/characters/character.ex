defmodule Elvenhearth.Characters.Character do
  use Ecto.Schema
  import Ecto.Changeset

  schema "characters" do
    field(:name, :string)
    field(:race, :string)
    field(:items, {:array, :map})
    belongs_to(:user, Elvenhearth.Users.User)

    timestamps()
  end

  @required_fields ~w(name race user_id)a
  @allowed_fields ~w(items)a

  def changeset(character, params \\ %{}) do
    character
    |> cast(params, @required_fields ++ @allowed_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:race)
  end
end

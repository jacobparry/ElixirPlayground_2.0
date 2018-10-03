defmodule Elvenhearth.Characters.Character do
  use Ecto.Schema
  import Ecto.Changeset

  schema "characters" do
    field :name, :string
    field :race, :string
    belongs_to :user, Elvenhearth.Users.User

    timestamps()
  end

  @required_fields ~w(name race)a

  def changeset(character, params \\ %{}) do
    character
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end
end

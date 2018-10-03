defmodule Elvenhearth.Users.User do
  use Ecto.Schema

  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :password, :string
    field :email, :string
    field :age, :integer

    has_many :characters, Elvenhearth.Characters.Character

    timestamps()
  end

  @required_fields ~w(username password email)a
  @optional_fields ~w(age)a

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields) #
  end
end

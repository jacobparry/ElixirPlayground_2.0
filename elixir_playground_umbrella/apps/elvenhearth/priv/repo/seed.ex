alias Elvenhearth.Users.{User, UserQueries}
alias Elvenhearth.Characters.{Character, CharacterQueries}

unless(UserQueries.any) do
  users = [
    User.changeset(%User{}, %{
      username: "test1",
      password: "1234",
      email: "test1@test.com"
      }
    ),
    User.changeset(%User{}, %{
      username: "test2",
      password: "1234",
      email: "test2@test.com"
      }
    ),
    User.changeset(%User{}, %{
      username: "test3",
      password: "1234",
      email: "test3@test.com"
      }
    )
  ]

  inserted_users =
    Enum.map(users, fn(user) ->
      UserQueries.create(user)
    end)

  Enum.map(inserted_users, fn(inserted_user) ->
    {:ok, user} = inserted_user
    Character.changeset(%Character{}, %{
      name: "Rand",
      race: "Human",
      user_id: user.id
    })
    |> CharacterQueries.create()
  end)
end

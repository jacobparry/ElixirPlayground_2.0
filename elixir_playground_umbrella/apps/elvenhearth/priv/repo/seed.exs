alias Elvenhearth.Users.{User, UserQueries}
alias Elvenhearth.Characters.{Character, CharacterQueries}

unless(UserQueries.any) do
  users = [
    User.changeset(%User{}, %{
      username: "user1",
      password: "1234",
      email: "user1@test.com"
      }
    ),
    User.changeset(%User{}, %{
      username: "user2",
      password: "1234",
      email: "user2@test.com"
      }
    ),
    User.changeset(%User{}, %{
      username: "user3",
      password: "1234",
      email: "user3@test.com"
      }
    )
  ]

  inserted_users =
    Enum.map(users, fn(user) ->
      UserQueries.create(user)
    end)

  [{_, user1}, {_, user2}, {_, user3}] = inserted_users

  character_list = [
    Character.changeset(%Character{}, %{
      name: "Rand",
      race: "Dragon",
      user_id: user1.id
    }),
    Character.changeset(%Character{}, %{
      name: "Matt",
      race: "Fox",
      user_id: user2.id
    }),
    Character.changeset(%Character{}, %{
      name: "Perrin",
      race: "Wolf",
      user_id: user3.id
    }),
    Character.changeset(%Character{}, %{
      name: "Trolloc",
      race: "Shadow Spawn",
    })
  ]

  # This is called a Comprehension. It is like a loop on steroids
  for character <- character_list do
    CharacterQueries.create(character)
  end

  # You can pattern match using comprehensions.
  for %Ecto.Changeset{valid?: true, changes: changes} = changeset <- character_list do
    IO.inspect(changes)
  end
end

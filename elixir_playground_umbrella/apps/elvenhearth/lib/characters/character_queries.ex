defmodule Elvenhearth.Characters.CharacterQueries do
  import Ecto.Query

  alias Elvenhearth.Repo
  alias Elvenhearth.Characters.Character

  def get_all() do
    Repo.all(from Character)
  end

  def get_all_for_user(user) do
    Repo.all(
      from c in Character,
      where: c.user_id == ^user.id
    )
    # |> IO.inspect
  end

  def get_by_id(id) do
    query =
      from c in Character,
      where: c.id == ^id

    Repo.one(query)
  end

  def any do
    count =
      Repo.one(
        from c in Character,
        select: count(c.id)
      )
    count != 0
  end

  def create(character) do
    Repo.insert(character)
  end

  def update(character) do
    Repo.update(character)
  end
end

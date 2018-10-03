defmodule Elvenhearth.Users.UserQueries do
  import Ecto.Query

  alias Elvenhearth.Repo
  alias Elvenhearth.Users.User

  def get_all do
    Repo.all(from User)
  end

  def get_by_id(id) do
    query =
      from u in User,
      where: u.id == ^id

    Repo.all(query)
  end

  def any do
    count =
      Repo.one(
        from u in User,
        select: count(u.id)
      )
    count != 0
  end

  def create(user) do
    Repo.insert(user)
  end
end

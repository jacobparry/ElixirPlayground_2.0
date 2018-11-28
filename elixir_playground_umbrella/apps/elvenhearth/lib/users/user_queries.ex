defmodule Elvenhearth.Users.UserQueries do
  import Ecto.Query

  alias Comeonin.Ecto.Password
  alias Elvenhearth.Repo
  alias Elvenhearth.Users.User

  def get_all do
    Repo.all(from(User))
  end

  def get_by_id(id) do
    query =
      from(u in User,
        where: u.id == ^id
      )

    Repo.one(query)
  end

  def get_by_username(username) do
    query =
      from(u in User,
        where: u.username == ^username
      )

    Repo.one(query)
  end

  def any do
    count =
      Repo.one(
        from(u in User,
          select: count(u.id)
        )
      )

    count != 0
  end

  def create(user) do
    Repo.insert(user)
  end

  def update(user) do
    Repo.update(user)
  end

  def authenticate(role, username, password) do
    user = get_by_username(username)

    with %{password: digest} <- user,
         true <- Password.valid?(password, digest) do
      {:ok, user}
    else
      _ -> :error
    end
  end
end

defmodule Elvenhearth.Authentication.Authenticate do
  @moduledoc """
  The Authentication context
  """

  import Ecto.Query

  alias Elvenhearth.Repo
  alias Comeonin.Ecto.Password
  alias Elvenhearth.Users.UserQueries

  def authenticate(id, username, user_submitted_password) do
    user = UserQueries.get_by_id(id)
    IO.inspect(user)

    with %{password: saved_password} <- user,
        true <- Password.valid?(user_submitted_password, saved_password)
    do
      {:ok, user}
    else
      _ -> :error
    end
  end
end

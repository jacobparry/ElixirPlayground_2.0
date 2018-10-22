defmodule ElvenhearthPhxWeb.Resolvers.UserResolver do
  alias Elvenhearth.Users.UserQueries
  alias Elvenhearth.Users.User

  def list_users(_, _, _) do
    {:ok, UserQueries.get_all()}
  end

  def anonymize_password(_, _, _) do
    {:ok, "Wouldn't you like to know"}
  end

  def get_user_for_character(character, _, _) do
    {:ok, UserQueries.get_by_id(character.user_id)}
  end

  def create_user(_parent, %{input: params} = args, _resolution) do
    user = User.changeset(%User{}, params)

    UserQueries.create(user)
  end
end

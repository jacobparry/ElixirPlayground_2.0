defmodule ElvenhearthPhxWeb.Resolvers.UserResolver do
  alias Elvenhearth.Users.UserQueries

  def list_users(_, _, _) do
    {:ok, UserQueries.get_all()}
  end

  def anonymize_password(_, _, _) do
    {:ok, "Wouldn't you like to know"}
  end

  def get_user_for_character(character, _, _) do
    {:ok, UserQueries.get_by_id(character.user_id)}
  end
end

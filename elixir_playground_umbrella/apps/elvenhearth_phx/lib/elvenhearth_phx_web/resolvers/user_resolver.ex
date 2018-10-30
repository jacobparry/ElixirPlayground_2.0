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

    case UserQueries.create(user) do
      {:ok, user} ->
        Absinthe.Subscription.publish(ElvenhearthPhxWeb.Endpoint, user, new_user: "*")
        {:ok, user}
      _error ->
        {:ok, nil}
    end
  end

  def update_user(_parent, %{input: params} = args, _resolution) do
    user = UserQueries.get_by_id(params[:id])
    IO.inspect user

    updated_user = User.update(user, params)

    UserQueries.update(updated_user)
  end
end

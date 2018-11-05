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
      {:error, changeset} ->
        {
          :error,
          message: "Could not create user",
          details: error_details(changeset)
        }
    end
  end

  defp error_details(changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(fn {msg, _} -> msg end)
  end

  def update_user(_parent, %{input: params} = args, _resolution) do
    user = UserQueries.get_by_id(params[:id])
    updated_user = User.changeset(user, params)
    IO.inspect(updated_user)
    case UserQueries.update(updated_user) do
      {:ok, _} = success ->
        success
      {:error, changeset} ->
        {
          :error,
          message: "Could not update user",
          details: error_details(changeset)
        }
    end
  end
end

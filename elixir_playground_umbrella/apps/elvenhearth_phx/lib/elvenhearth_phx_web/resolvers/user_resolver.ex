defmodule ElvenhearthPhxWeb.Resolvers.UserResolver do

  @users [
    %{
      username: "Rand",
      password: "1234",
      email: "test@test.com"
    },
    %{
      username: "Perrin",
      password: "5678"
    }
  ]

  def list_users(_, _, _) do
    {:ok, @users}
  end

  def anonymize_password(_, _, _) do
    {:ok, "Wouldn't you like to know"}
  end

  def characters_for_user(_, _, _) do
    {:ok, %{}}
  end
end

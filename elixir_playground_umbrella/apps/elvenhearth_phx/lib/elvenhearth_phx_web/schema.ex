defmodule ElvenhearthPhxWeb.Schema do
  use Absinthe.Schema

  query do
    field :health, :string do
      resolve(fn _, _, _ ->
        {:ok, "up"}
      end)
    end

    field :users, list_of(:user) do
      resolve &list_users/3
    end
  end

  object :user do
    field :username, :string
    field :password, :string
    field :email, non_null(:string)
  end

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

end

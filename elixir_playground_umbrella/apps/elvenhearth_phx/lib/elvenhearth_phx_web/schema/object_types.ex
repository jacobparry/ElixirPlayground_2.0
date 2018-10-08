defmodule ElvenhearthPhxWeb.Schema.ObjectTypes do
  use Absinthe.Schema.Notation

  alias ElvenhearthPhxWeb.Resolvers.UserResolver

  object :user do
    field :username, :string
    field :password, :string do
      resolve &UserResolver.anonymize_password/3
    end
    field :email, non_null(:string)

    field :characters, list_of(:character) do
      resolve &UserResolver.characters_for_user/3
    end
  end

  object :character do
    field :name, :string
    field :race, :string
  end
end

defmodule ElvenhearthPhxWeb.Schema.ObjectTypes do
  use Absinthe.Schema.Notation

  alias ElvenhearthPhxWeb.Resolvers.{UserResolver, CharacterResolver}

  object :user do
    field :username, :string
    field :password, :string do
      resolve &UserResolver.anonymize_password/3
    end
    field :email, non_null(:string)

    field :characters, list_of(:character) do
      resolve &CharacterResolver.get_characters_for_user/3
    end
  end

  object :character do
    field :name, :string
    field :race, :string
    field :user, :user do
      resolve &UserResolver.get_user_for_character/3
    end
  end

  input_object :create_character_input do
    field :name, non_null(:string)
    field :race, non_null(:string)
  end
end

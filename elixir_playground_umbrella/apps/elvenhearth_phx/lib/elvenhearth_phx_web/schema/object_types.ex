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

  object :create_character_result do
    field :character, :character
    field :errors, list_of(:input_error)
  end

  object :input_error do
    field :key, non_null(:string)
    field :message, non_null(:string)
  end

  input_object :create_user_input do
    field :username, non_null(:string)
    field :password, non_null(:string)
    field :email, non_null(:string)
    field :age, :integer
  end

  input_object :create_character_input do
    field :name, non_null(:string)
    field :race, non_null(:string)
    field :user_id, non_null(:string)
  end

  input_object :update_user_input do
    field :id, non_null(:integer)
    field :username, :string
    field :password, :string
    field :email, :string
    field :age, :string
  end
end

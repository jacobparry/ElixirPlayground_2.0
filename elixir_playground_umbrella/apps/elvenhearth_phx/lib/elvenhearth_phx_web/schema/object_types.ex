defmodule ElvenhearthPhxWeb.Schema.ObjectTypes do
  use Absinthe.Schema.Notation

  alias ElvenhearthPhxWeb.Resolvers.{UserResolver, CharacterResolver}

  interface :user do
    field(:username, :string)
    field(:password, :string)
    field(:email, non_null(:string))

    field :characters, list_of(:character) do
      resolve(&CharacterResolver.get_characters_for_user/3)
    end

    resolve_type(fn
      %{role: "DM"}, _ -> :dungeon_master
      %{role: "PLAYER"}, _ -> :player
    end)
  end

  object :dungeon_master do
    interface(:user)
    field(:username, :string)

    field :password, :string do
      resolve(&UserResolver.anonymize_password/3)
    end

    field(:email, non_null(:string))

    field :all_characters, list_of(:character) do
      resolve(&CharacterResolver.list_characters/3)
    end

    field :all_users, list_of(:user) do
      resolve(&UserResolver.list_users/3)
    end

    field :characters, list_of(:character) do
      resolve(&CharacterResolver.get_characters_for_user/3)
    end
  end

  object :player do
    interface(:user)
    field(:username, :string)

    field :password, :string do
      resolve(&UserResolver.anonymize_password/3)
    end

    field(:email, non_null(:string))

    field :characters, list_of(:character) do
      resolve(&CharacterResolver.get_characters_for_user/3)
    end
  end

  object :character do
    field(:name, :string)
    field(:race, :string)

    field :user, :user do
      resolve(&UserResolver.get_user_for_character/3)
    end

    field(:items, list_of(:item_info))
  end

  object :item_info do
    field(:name, :string)
    field(:value, :string)
  end

  object :create_character_result do
    field(:character, :character)
    field(:errors, list_of(:input_error))
  end

  object :create_user_result do
    field(:user, :user)
    field(:errors, list_of(:input_error))
  end

  object :update_character_result do
    field(:character, :character)
    field(:errors, list_of(:input_error))
  end

  object :input_error do
    field(:key, non_null(:string))
    field(:message, non_null(:string))
  end

  object :session do
    field(:token, :string)
    field(:user, :user)
  end

  enum :role do
    value(:dungeon_master)
    value(:player)
  end

  input_object :create_user_input do
    field(:username, non_null(:string))
    field(:password, non_null(:string))
    field(:email, non_null(:string))
    field(:age, :integer)
  end

  input_object :create_character_input do
    field(:name, non_null(:string))
    field(:race, non_null(:string))
    field(:user_id, non_null(:string))
  end

  input_object :update_user_input do
    field(:id, non_null(:integer))
    field(:username, :string)
    field(:password, :string)
    field(:email, :string)
    field(:age, :string)
  end

  input_object :update_character_input do
    field(:id, non_null(:integer))
    field(:name, :string)
    field(:race, :string)
  end

  input_object :login_input do
    field(:username, non_null(:string))
    field(:password, non_null(:string))
    field(:role, non_null(:string))
  end
end

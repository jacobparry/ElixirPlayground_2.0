defmodule ElvenhearthPhxWeb.Schema.ObjectMutations do
  use Absinthe.Schema.Notation

  alias ElvenhearthPhxWeb.Resolvers.{UserResolver, CharacterResolver}

  object :object_mutations do
    field :create_character, :character do
      arg :input, non_null(:create_character_input)
      resolve &CharacterResolver.create_character/3
    end

    field :create_user, :user do
      arg :input, non_null(:create_user_input)
      resolve &UserResolver.create_user/3
    end
  end


end

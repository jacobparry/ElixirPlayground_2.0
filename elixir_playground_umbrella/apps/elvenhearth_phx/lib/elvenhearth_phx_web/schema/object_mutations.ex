defmodule ElvenhearthPhxWeb.Schema.ObjectMutations do
  use Absinthe.Schema.Notation
  alias ElvenhearthPhxWeb.Schema.Middleware
  alias ElvenhearthPhxWeb.Resolvers.{UserResolver, CharacterResolver}

  object :object_mutations do
    field :create_character, :create_character_result do
      arg :input, non_null(:create_character_input)
      resolve &CharacterResolver.create_character/3
      middleware Middleware.ChangesetErrors
    end

    field :create_user, :create_user_result do
      arg :input, non_null(:create_user_input)
      resolve &UserResolver.create_user/3
      middleware Middleware.ChangesetErrors
    end

    field :update_character, :update_character_result do
      arg :input, non_null(:update_character_input)
      resolve &CharacterResolver.update_character/3
      middleware Middleware.ChangesetErrors
    end

    field :update_user, :user do
      arg :input, non_null(:update_user_input)
      resolve &UserResolver.update_user/3
    end
  end


end

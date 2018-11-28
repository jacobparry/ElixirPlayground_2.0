defmodule ElvenhearthPhxWeb.Schema.ObjectMutations do
  use Absinthe.Schema.Notation
  alias ElvenhearthPhxWeb.Schema.Middleware
  alias ElvenhearthPhxWeb.Resolvers.{UserResolver, CharacterResolver}

  object :object_mutations do
    field :create_character, :create_character_result do
      arg(:input, non_null(:create_character_input))
      middleware(Middleware.Authorize, "DM")
      resolve(&CharacterResolver.create_character/3)
    end

    field :create_user, :create_user_result do
      arg(:input, non_null(:create_user_input))
      resolve(&UserResolver.create_user/3)
    end

    field :update_character, :update_character_result do
      arg(:input, non_null(:update_character_input))
      resolve(&CharacterResolver.update_character/3)
    end

    field :update_user, :user do
      arg(:input, non_null(:update_user_input))
      resolve(&UserResolver.update_user/3)
    end

    field :login, :session do
      arg(:input, non_null(:login_input))
      resolve(&UserResolver.login/3)
    end
  end
end

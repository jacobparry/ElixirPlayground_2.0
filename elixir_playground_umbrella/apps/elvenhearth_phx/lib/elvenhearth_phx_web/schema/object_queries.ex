defmodule ElvenhearthPhxWeb.Schema.ObjectQueries do
  use Absinthe.Schema.Notation

  alias ElvenhearthPhxWeb.Schema.Middleware
  alias ElvenhearthPhxWeb.Resolvers.{
    AuthorizationResolver,
    UserResolver,
    CharacterResolver
  }

  object :object_queries do
    field :me, :user do
      middleware Middleware.Authorize, :any
      resolve &AuthorizationResolver.me/3
    end

    # field :users, list_of(:user) do
    #   resolve &UserResolver.list_users/3
    # end

    # field :characters, list_of(:character) do
    #   resolve &CharacterResolver.list_characters/3
    # end
  end
end

defmodule ElvenhearthPhxWeb.Schema.ObjectQueries do
  use Absinthe.Schema.Notation

  alias ElvenhearthPhxWeb.Resolvers.UserResolver

  object :object_queries do
    field :users, list_of(:user) do
      resolve &UserResolver.list_users/3
    end
  end
end

defmodule ElvenhearthPhxWeb.Schema do
  use Absinthe.Schema
  use ApolloTracing

  import_types ElvenhearthPhxWeb.Schema.{
    ObjectTypes,
    ObjectQueries,
    ObjectMutations,
    ObjectSubscriptions
  }

  query do
    field :health, :string do
      resolve(fn _, _, _ ->
        {:ok, "up"}
      end)
    end

    import_fields :object_queries
  end

  mutation do
    import_fields :object_mutations
  end

  subscription do
    import_fields :object_subscriptions
  end

end

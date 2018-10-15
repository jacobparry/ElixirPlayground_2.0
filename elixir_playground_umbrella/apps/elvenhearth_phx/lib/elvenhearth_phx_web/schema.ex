defmodule ElvenhearthPhxWeb.Schema do
  use Absinthe.Schema
  use ApolloTracing

  import_types ElvenhearthPhxWeb.Schema.ObjectTypes
  import_types ElvenhearthPhxWeb.Schema.ObjectQueries
  import_types ElvenhearthPhxWeb.Schema.ObjectMutations

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


end

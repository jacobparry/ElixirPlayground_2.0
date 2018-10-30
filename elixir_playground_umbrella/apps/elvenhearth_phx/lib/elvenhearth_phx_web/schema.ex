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

  subscription do
    field :new_user, :user do
      config fn _args, _info ->
        {:ok, topic: "*"}
      end
      resolve fn root, _, _ ->
        IO.inspect(root)
        {:ok, root}
      end
    end


  end

end

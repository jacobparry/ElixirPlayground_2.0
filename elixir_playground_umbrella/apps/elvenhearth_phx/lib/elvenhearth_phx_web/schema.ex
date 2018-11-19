defmodule ElvenhearthPhxWeb.Schema do
  use Absinthe.Schema
  alias ElvenhearthPhxWeb.Schema.Middleware

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

  def middleware(middleware, field, object) do
    IO.inspect [
      object: object.identifier,
      field: field.identifier
    ]
    middleware
    |> add(:apollo_tracing, field, object)
    |> add(:changeset_errors, field, object)
  end

  defp add(middleware, :apollo_tracing, _field, _object) do
    middleware ++ [ApolloTracing.Middleware.Tracing]
  end

  defp add(middleware, :changeset_errors, field, %{identifier: :mutation}) do
    middleware ++ [Middleware.ChangesetErrors]
  end

  defp add(middleware, :changeset_errors, _field, _object) do
    middleware
  end
end

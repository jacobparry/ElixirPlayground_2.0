defmodule ElvenhearthPhxWeb.Schema do
  use Absinthe.Schema
  alias ElvenhearthPhxWeb.Schema.Middleware

  import_types(ElvenhearthPhxWeb.Schema.{
    ObjectTypes,
    ObjectQueries,
    ObjectMutations,
    ObjectSubscriptions
  })

  query do
    field :health, :string do
      resolve(fn _, _, _ ->
        {:ok, "up"}
      end)
    end

    import_fields(:object_queries)
  end

  mutation do
    import_fields(:object_mutations)
  end

  subscription do
    import_fields(:object_subscriptions)
  end

  def middleware(middleware, field, object) do
    # IO.inspect [
    #   object: object.identifier,
    #   field: field.identifier
    # ]
    middleware
    |> add(:apollo_tracing, field, object)
    |> add(:items, field, object)
    |> add(:changeset_errors, field, object)
    |> add(:debug, field, object)
  end

  defp add(middleware, :apollo_tracing, _field, _object) do
    middleware ++ [ApolloTracing.Middleware.Tracing]
  end

  defp add(middleware, :changeset_errors, field, %{identifier: :mutation}) do
    middleware ++ [Middleware.ChangesetErrors]
  end

  defp add(middleware, :items, field, %{identifier: :item_info} = object) do
    new_middleware = {Absinthe.Middleware.MapGet, to_string(field.identifier)}

    middleware
    |> Absinthe.Schema.replace_default(new_middleware, field, object)
  end

  defp add(middleware, :debug, _field, _object) do
    if System.get_env("DEBUG") do
      [{Middleware.Debug, :start}] ++ middleware
    else
      middleware
    end
  end

  defp add(middleware, _middleware_type, _field, _object) do
    middleware
  end
end

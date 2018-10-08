defmodule ElvenhearthPhxWeb.Schema do
  use Absinthe.Schema

  import_types ElvenhearthPhxWeb.Schema.ObjectTypes
  import_types ElvenhearthPhxWeb.Schema.ObjectQueries

  query do
    field :health, :string do
      resolve(fn _, _, _ ->
        {:ok, "up"}
      end)
    end

    import_fields :object_queries
  end
end

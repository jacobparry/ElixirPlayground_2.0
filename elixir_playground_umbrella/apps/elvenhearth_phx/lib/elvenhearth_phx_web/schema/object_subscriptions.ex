defmodule ElvenhearthPhxWeb.Schema.ObjectSubscriptions do
  use Absinthe.Schema.Notation

  object :object_subscriptions do
    field :new_user, :user do
      config fn _args, _info ->
        {:ok, topic: "*"}
      end
    end
  end
end

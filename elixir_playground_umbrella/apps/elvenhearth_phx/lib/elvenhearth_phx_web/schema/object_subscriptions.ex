defmodule ElvenhearthPhxWeb.Schema.ObjectSubscriptions do
  use Absinthe.Schema.Notation

  object :object_subscriptions do
    field :new_user, :user do
      config fn _args, _info ->
        {:ok, topic: "*"}
      end
    end

    field :update_user, :user do
      arg :id, non_null(:id)

      config fn args, _info ->
        {:ok, topic: args.id}
      end

      trigger [:update_user], topic: fn
        user -> [user.id]
        _ -> []
      end

      resolve fn user, _, _ ->
        IO.inspect(user)
        {:ok, user}
      end
    end
  end
end

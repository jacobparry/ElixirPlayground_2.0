defmodule ElvenhearthPhxWeb.Resolvers.AuthorizationResolver do

  def me(_parent, _args, %{context: %{current_user: current_user}} = _resolution) do
    {:ok, current_user}
  end

  def me(_, _, _) do
    {:ok, nil}
  end
end

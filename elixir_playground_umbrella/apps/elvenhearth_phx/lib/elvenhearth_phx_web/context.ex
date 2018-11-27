defmodule ElvenhearthPhxWeb.Context do
  @behavior Plug
  import Plug.Conn

  def init(opts) do
    opts
  end

  def call(conn, _) do
    context = build_context(conn)
    IO.inspect "*****************************************************************"
    IO.inspect [context: context]
    Absinthe.Plug.put_options(conn, context: context)
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
      {:ok, data} <- ElvenhearthPhxWeb.Authentication.verify(token),
      %{} = user <- get_user(data)
    do
      %{current_user: user}
    else
      _ -> %{}
    end
  end

  defp get_user(%{id: id, role: role}) do
    Elvenhearth.Users.UserQueries.get_by_id(id)
  end
end

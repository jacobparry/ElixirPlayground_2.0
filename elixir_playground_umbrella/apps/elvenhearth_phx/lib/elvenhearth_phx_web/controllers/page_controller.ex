defmodule ElvenhearthPhxWeb.PageController do
  use ElvenhearthPhxWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

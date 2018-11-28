defmodule ElvenhearthPhxWeb.Router do
  use ElvenhearthPhxWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
    plug(ElvenhearthPhxWeb.Context)
  end

  scope "/", ElvenhearthPhxWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
  end

  scope "/playground" do
    pipe_through(:api)

    forward("/api", Absinthe.Plug, schema: ElvenhearthPhxWeb.Schema)

    forward("/graphiql", Absinthe.Plug.GraphiQL,
      schema: ElvenhearthPhxWeb.Schema,
      interface: :playground,
      socket: ElvenhearthPhxWeb.UserSocket,
      pipeline: {ApolloTracing.Pipeline, :plug}
    )
  end

  # Other scopes may use custom stacks.
  # scope "/api", ElvenhearthPhxWeb do
  #   pipe_through :api
  # end
end

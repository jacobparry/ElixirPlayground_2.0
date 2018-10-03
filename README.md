# ElixirPlayground_2.0
A sandbox for learning Elixir and its environment

# Setup
* Install Elixir, node, postgres
* mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez

# Details
1. https://github.com/jacobparry/ElixirPlayground_2.0
  * In the github repo, there are Pull Requests made comparing each branch to the previous one

# 1.0-setup-elixir-umbrella-app
1. Run the following command in the repo 
  * `mix new elixir_playground_umbrella --umbrella` 
  * This scaffolds an umbrella application.
  * Similar to a .NET Solutions.
  * Used for delineating logic or separating distince services (think micro services)

# 1.1-setup-elixir-logic-app
1. Navigate into the `elixir_playground_umbrella/apps` directory
2. Run the following command
  * `mix new elvenhearth --sup`
  * A --sup option can be given to generate an OTP application skeleton including a supervision tree. Normally an app is generated without a supervisor and without the app callback.

# 1.2-setup-elixir-phoenix-app
1. Navigate into the `elixir_playground_umbrella/apps` directory
2. Run the following command
  * `mix phx.new elvenhearth_phx --no-ecto`
  * When asked, select `Y` or the default option for installing the dependencies.
  * The --no-ecto tells phoenix not to include the ecto wrapper or any of the files needed to interact with ecto.

# 1.3-setup-ecto
1. Open the file `elixir_playground_umbrella/apps/elvenhearth/mix.exs`
  * Add the following dependencies found on hex.pm to the dependency block:
    1. `{:ecto, "~> 2.2"}` or https://hex.pm/packages/ecto (for the latest)
    2. `{:postgrex, "~> 0.13.5"}` or https://hex.pm/packages/postgrex (for the latest)
  * Add `:ecto` and `postgrex` to the extra_applications list like so:
    1. `extra_applications: [:logger, :postgrex, :ecto]`
  * Run `mix deps.get`

2. Open the file `elixir_playground_umbrella/apps/elvenhearth/config/config.exs`
  * Add the following config blocks to the bottom of the file:
      ```
        config :elvenhearth, Elvenhearth.Repo,
          adapter: Ecto.Adapters.Postgres,
          database: "elvenhearth",
          username: "postgres",
          password: "postgres"
        
        config :elvenhearth, ecto_repos: [Elvenhearth.Repo]
      ```
3. Create the file `elixir_playground_umbrella/apps/elvenhearth/lib/repo.ex`
  * Define the module as `Elvenhearth.Repo`
  * Add this line: `use Ecto.Repo, otp_app: :elvenhearth`
    1. This defines this repo as an ecto repo.

4. Open the file `elixir_playground_umbrella/apps/elvenhearth/lib/elvenhearth/application.ex`
  * Inside of the `def start` function, add the following line as the first line inisde of it:
    1. `import Supervisor.Spec`
  * Inside of the `children = []` list in the `def start` function, add in:
    1. `worker(Elvenhearth.Repo, [])`
    2. This allows the repo to be restarted by a supervisor if it dies.

5. Run `mix ecto.create`
  * This will create the database as configured in step 2 above.
  * Running `mix ecto` will tell you the other tasks that ecto can perform`

# 1.4-setup-absinthe
1. Open the file `elixir_playground_umbrella/apps/elvenhearth_phx/mix.exs`
  * Add the following dependencies found on hex.pm to the dependency block:
    1. `{:absinthe, "~> 1.4"}` or https://hex.pm/packages/absinthe for latest
    2. `{:absinthe_plug, "~> 1.4"}` or https://hex.pm/packages/absinthe_plug for latest
    3. `{:absinthe_phoenix, "~> 1.4"}` or https://hex.pm/packages/absinthe_phoenix for latest
    4. `{:absinthe_relay, "~> 1.4"}` or https://hex.pm/packages/absinthe_relay for latest
  * Run `mix deps.get`
  
2. Open the file `elixir_playground_umbrella/apps/elvenhearth_phx/lib/elvenhearth_phx/application.ex`
 * Inside of the `children = []` list in the `def start` function, add in:
    1. `supervisor(Absinthe.Subscription, [ElvenhearthPhxWeb.Endpoint])`
    2. This allows the repo to be restarted by a supervisor if it dies.

3. Open the file `elixir_playground_umbrella/apps/elvenhearth_phx/lib/elvenhearth_phx_web/channels/user_socket.ex`
  * At the top of the module, inside of the `defmodule do`, add:
    1. `use Absinthe.Phoenix.Socket, schema: ElvenhearthPhxWeb.Schema`
    2. This allows subscriptions to work.

4. Open the file `elixir_playground_umbrella/apps/elvenhearth_phx/lib/elvenhearth_phx_web/router.ex`
  * Add the graphiql route to the router:
    1. 
      ```
        scope "/playground" do
          pipe_through :api

          forward("/graphiql", Absinthe.Plug.GraphiQL,
            schema: ElvenhearthPhxWeb.Schema,
            interface: :playground
          )
        end
      ```
5. Create the file `elixir_playground_umbrella/apps/elvenhearth_phx/lib/elvenhearth_phx_web/schema.ex`
  * `defmodule ElvenhearthPhxWeb.Schema do`
  * Add `use Absinthe.Schema` at the top of the module
  * Add this simple query:
    1.
      ```
        query do
          field :health, :string do
            resolve(fn _, _, _ ->
              {:ok, "up"}
            end)
          end
        end
      ```


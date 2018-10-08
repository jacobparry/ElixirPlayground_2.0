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
3. Navigate into `elixir_playground_umbrella/apps/elvenhearth_phx/assets`
  * Run `npm install`

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
6. From `elixir_playground_umbrella`, run the following command:
  * `mix phx.server`
  * Now navigate to localhost:4000/playground/graphiql
  * You can explore this interface that will come into play later.

# 2.0-models
1. Create a `User` Model
  * Create a new folder and file `users/user.ex` at `elixir_playground_umbrella/apps/elvenhearth/lib/users/user.ex`
  ```
    defmodule Elvenhearth.Users.User do
      use Ecto.Schema

      import Ecto.Changeset

      schema "users" do
        field :username, :string
        field :password, :string
        field :email, :string
        field :age, :integer

        has_many :characters, Elvenhearth.Characters.Character

        timestamps()
      end

      @required_fields ~w(username password email)a
      @optional_fields ~w(age)a

      def changeset(user, params \\ %{}) do
        user
        |> cast(params, @required_fields ++ @optional_fields)
        |> validate_required(@required_fields) #
      end
    end
  ```
2. Create a `Character` Model
  * Create a new folder and file `users/user.ex` at `elixir_playground_umbrella/apps/elvenhearth/lib/characters/character.ex`
  ```
    defmodule Elvenhearth.Characters.Character do
      use Ecto.Schema
      import Ecto.Changeset

      schema "characters" do
        field :name, :string
        field :race, :string
        belongs_to :user, Elvenhearth.Users.User

        timestamps()
      end

      @required_fields ~w(name race)a

      def changeset(character, params \\ %{}) do
        character
        |> cast(params, @required_fields)
        |> validate_required(@required_fields)
      end
    end
  ```

3. Create migrations to create the `users` and `characters` tables
  * Navigate to `elixir_playground_umbrella/apps/elvenhearth`
    1. Run `mix ecto.gen.migration add_users_table`:
      * Add the following to the `def change do` in the generated migration file
        ```
          create table(:users) do
            add :username, :string, size: 50
            add :password, :string, size: 100
            add :email, :string, size: 50
            add :age, :integer

            timestamps()
          end
        ```
    2. Run `mix ecto.gen.migration add_characters_table`
      * Add the following to the `def change do` in the generated migration file
        ```
          create table(:characters) do
            add :name, :string
            add :race, :string
            add :user_id, references(:users, on_delete: :nothing)

            timestamps()
          end
        ```
    3. Run `mix ecto.migrate` to run create tables in the database.
      * If you open postgres by running `psql -d [database name], you will see 3 tables:
        1. `characters` and `users`
          * By running `\d characters` you will see that a Foreign key has been added for users.
        2. `schema_migrations`
          * This is how the app keeps track of what migrations have been run.

4. Create queries for `users` and `characters`
  * Create a file `user_queries.ex` at `elixir_playground_umbrella/apps/elvenhearth/lib/users/user_queries.ex`
  1. 
  ```
    defmodule Elvenhearth.Users.UserQueries do
      import Ecto.Query

      alias Elvenhearth.Repo
      alias Elvenhearth.Users.User

      def get_all do
        Repo.all(from User)
      end

      def get_by_id(id) do
        query =
          from u in User,
          where: u.id == ^id

        Repo.all(query)
      end

      def any do
        count =
          Repo.one(
            from u in User,
            select: count(u.id)
          )
        count != 0
      end

      def create(user) do
        Repo.insert(user)
      end
    end
  ```
  * Create a file `character_queries.ex` at `elixir_playground_umbrella/apps/elvenhearth/lib/characters/character_queries.ex`
    1. 
    ```
      defmodule Elvenhearth.Characters.CharacterQueries do
        import Ecto.Query

        alias Elvenhearth.Repo
        alias Elvenhearth.Characters.Character

        def get_all_for_user(user) do
          Repo.all(
            from c in Character,
            where: c.user_id == ^user.id
          )
        end

        def any do
          count =
            Repo.one(
              from c in Character,
              select: count(c.id)
            )
          count != 0
        end

        def create(character) do
          Repo.insert(character)
        end
      end
    ```
5. Seeds
  * Create a file `seed.exs` located at `elixir_playground_umbrella/apps/elvenhearth/priv/repo/seed.exs`
    1. 
      ```
        alias Elvenhearth.Users.{User, UserQueries}
        alias Elvenhearth.Characters.{Character, CharacterQueries}

        unless(UserQueries.any) do
          users = [
            User.changeset(%User{}, %{
              username: "test1",
              password: "1234",
              email: "test1@test.com"
              }
            ),
            User.changeset(%User{}, %{
              username: "test2",
              password: "1234",
              email: "test2@test.com"
              }
            ),
            User.changeset(%User{}, %{
              username: "test3",
              password: "1234",
              email: "test3@test.com"
              }
            )
          ]

          inserted_users =
            Enum.map(users, fn(user) ->
              UserQueries.create(user)
            end)

          Enum.map(inserted_users, fn(inserted_user) ->
            {:ok, user} = inserted_user
            Character.changeset(%Character{}, %{
              name: "Rand",
              race: "Human",
              user_id: user.id
            })
            |> CharacterQueries.create()
          end)
        end
      ```
    2. Run `mix run priv/repo/seed.exs` from the logic app, `elvenhearth` to run the seeds.
    3. Just play around with the seeds. You can see that there are a variety of topics that can be explored with what is happening in this file:
      * `alias` allows you to use the last part of the path instead of having to type the whole thing out.
      * `unless(UserQueries.any) do` allows for a simple way to only add seeds if there aren't already some in the database
      * `User.changeset` ties to the user model that we created above. If you delete some of the fields, you an change the validity of the changeset. (pro tip, inspect the users list after making changes.)
      * `Enum` is an elixir library that allows you to enumarate over lists in a variety of ways.

# 3.0-query-basics
* In the `elixir_playground_umbrella/apps/elvenhearth_phx/lib/elvenhearth_phx_web/schema.ex` file, add the following stuff:
1. Create the user object on the schema
  ```
    object :user do
      field :username, :string
      field :password, :string
      field :email, non_null(:string)
    end
  ```

2. Add the users list field in the query block
  ```
    field :users, list_of(:user) do
      resolve &list_users/3
    end
  ```

3. Create a sample resolver method and something to populate it with
  ```
    @users [
      %{
        username: "Rand",
        password: "1234",
        email: "test@test.com"
      },
      %{
        username: "Perrin",
        password: "5678"
      }
    ]

    def list_users(_, _, _) do
      {:ok, @users}
    end
  ```

# 4.0-domain-structure
1. Break the Objects and the Query fields out into separate modules
  * 
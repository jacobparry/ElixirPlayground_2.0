# ElixirPlayground_2.0
A sandbox for learning Elixir and its environment
* Install Elixir, node, postgres
* mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez

# 1.0-elixir-umbrella-app
1. Run the following command in the repo 
  * `mix new elixir_playground_umbrella --umbrella` 
  * This scaffolds an umbrella application.
  * Similar to a .NET Solutions.
  * Used for delineating logic or separating distince services (think micro services)

# 1.1-elixir-logic-app
1. Navigate into the `elixir_playground_umbrella/apps` directory
2. Run the following command
  * `mix new elvenhearth --sup`
  * A --sup option can be given to generate an OTP application skeleton including a supervision tree. Normally an app is generated without a supervisor and without the app callback.

# 1.2-elixir-phoenix-app
1. Navigate into the `elixir_playground_umbrella/apps` directory
2. Run the following command
  * `mix phx.new elvenhearth_phx --no-ecto`
  * When asked, select `Y` or the default option for installing the dependencies.
  * The --no-ecto tells phoenix not to include the ecto wrapper or any of the files needed to interact with ecto.
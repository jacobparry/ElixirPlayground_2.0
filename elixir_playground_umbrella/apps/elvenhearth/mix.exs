defmodule Elvenhearth.MixProject do
  use Mix.Project

  def project do
    [
      app: :elvenhearth,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :postgrex, :ecto],
      mod: {Elvenhearth.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      # {:sibling_app_in_umbrella, in_umbrella: true},
      {:comeonin_ecto_password, "~> 2.2"}, # Used for Authentication
      {:ecto, "~> 2.2"},
      {:pbkdf2_elixir, "~> 0.12.3"}, # Used for Authentication
      {:postgrex, "~> 0.13.5"}
    ]
  end
end

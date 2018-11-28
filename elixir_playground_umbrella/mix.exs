defmodule ElixirPlaygroundUmbrella.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Dependencies listed here are available only for this
  # project and cannot be accessed from applications inside
  # the apps folder.
  #
  # Run "mix help deps" for examples and options.
  defp deps do
    [
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false}
    ]
  end

  defp aliases do
    [
      {:setup, ["ecto.drop", "ecto.create", "ecto.migrate"]},
      {:reset,
       ["ecto.drop", "ecto.create", "ecto.migrate", "run apps/elvenhearth/priv/repo/seed.exs"]},
      {:seed, "run apps/elvenhearth/priv/repo/seed.exs"},
      {:review, ["format", "test", "credo --strict"]}
    ]
  end
end

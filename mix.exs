defmodule Polls.MixProject do
  use Mix.Project

  def project do
    [
      app: :polls,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :corsica],
      mod: {Polls, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug, "~> 1.16.0"},
      {:bandit, "~> 1.5.2"},
      {:jason, "~> 1.4.1"},
      {:corsica, "~> 2.1.3"},
      {:websock_adapter, "~> 0.5.3"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"}
    ]
  end
end

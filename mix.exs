defmodule KV.Mixfile do
  use Mix.Project

  def project do
    [
      app: :kv,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :dev,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :maru],
      mod: {KV, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      {:libcluster, "~> 2.1"},
      {:distillery, "~> 1.5", runtime: false},
      {:ecto, "~> 2.1.6"},
      {:maru, "~> 0.12"},
      # Optional dependency for runtime configuration loading.
      {:confex, "~> 3.3"},
    ]
  end
end
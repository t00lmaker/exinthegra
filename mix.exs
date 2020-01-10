defmodule Exinthegra.MixProject do
  use Mix.Project

  def project do
    [
      app: :exinthegra,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(), 
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [   
      {:poison, "~> 2.2"},
      {:httpoison, "~> 0.9.0"},
      {:ex_doc, "~> 0.13.0", only: :dev},
      {:timex, "~> 3.0"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp description do
    """
    Elixir wrapper for REST Countries API (http://restcountries.eu/)
    """
  end

  defp package do
    [
     files: ["lib", "config", "mix.exs", "README*", "LICENSE*"],
     maintainers: ["Luan Pontes"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/t00lmaker/exinthegra"}
    ]
  end
end

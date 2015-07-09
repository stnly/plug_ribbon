defmodule PlugRibbon.Mixfile do
  use Mix.Project

  @version "0.2.1"

  def project do
    [app: :plug_ribbon,
     version: @version,
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     package: package,
     source_url: "https://github.com/stnly/plug_ribbon",
     homepage_url: "https://git.io/plug_ribbon",
     description: description]
  end

  defp description do
  """
  Injects a ribbon to your web application depending on the environment
  """
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [{:plug, ">= 0.13.0"}]
  end

  defp package do
    [contributors: ["Stanley Tan"],
     licenses: ["MIT"],
     links: %{GitHub: "https://git.io/plug_ribbon"},
     files: ~w(lib priv test mix.exs) ++
            ~w(LICENSE README.md)]
  end
end

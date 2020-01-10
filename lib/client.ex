defmodule Exinthegra.Client do
  @moduledoc """
    Elixir client http para a Api Strans Inthegra.  
  """

  use HTTPoison.Base
  
  @api_root "https://api.inthegra.strans.teresina.pi.gov.br/v1"

  @riculus_format_date "{WDshort}, {D} {Mshort} {YYYY} {h24}:{m}:{s} GMT"

  defp env(key) do
    env_key = key |> Atom.to_string |> String.upcase
    Application.get_env(:exinthegra, key, System.get_env(env_key))
  end

  defp get_token, do: "5d761a19-2fdb-4e05-b2b2-f136874c0beb"

  defp get_key, do: "290d623503d3409596202256231431ad"

  defp date, do: Timex.now |> Timex.format!(@riculus_format_date)

  defp get_credentials do 
    %{
      email: env(:login),
      password: env(:password)
    }
  end

  @spec login :: {:error, any} | {:ok, any}
  defp login do
    "/sigin" 
    |> post(get_credentials)
    |> resp
  end

  defp process_url(path), do: @api_root <> path

  defp process_request_body(req), do: Poison.encode!(req)

  defp process_request_headers(headers) do
    [{"Content-type", "application/json"},
     {"Date", date()},
     {"X-Auth-Token", get_token()},
     {"X-Api-Key", get_key()}
    ] ++ headers
	end

  @doc """
	Format the `HTTPoison.Response` struct as a tuple.
	"""
	def resp({status, res}) when status === :ok, do: {status, res.body}
	def resp({status, res}) when status === :error, do: {status, res.reason}
end

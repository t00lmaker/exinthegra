defmodule Exinthegra.Client do
  @moduledoc """
    Elixir client http para a Api Strans Inthegra.  
  """

  use HTTPoison.Base
  
  @host "https://api.inthegra.strans.teresina.pi.gov.br"

  defp env(key), do: Application.get_env(:exinthegra, key)

  defp get_token, do: env(:token)

  defp get_credentials do 
    [
      login: env(:login),
      password: env(:password),
      key: env(:key)
    ]
  end

  defp process_url(path), do: @host <> path

  defp process_request_body(req), do: Poison.encode!(req)

  defp process_request_headers(headers) do
		[{"Content-type", "application/json"}, {"Authorization", "Bearer #{get_token()}"}] ++ headers
	end

  @doc """
	Format the `HTTPoison.Response` struct as a tuple.
	"""
	def resp({status, res}) when status === :ok, do: {status, res.body}
	def resp({status, res}) when status === :error, do: {status, res.reason}
end

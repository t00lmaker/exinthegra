defmodule Exinthegra do
  @moduledoc """
    Elixir wrapper para a Api Strans Inthegra.  
  """
  import Exinthegra.Client, only: [get: 1, resp: 1]
  @doc """
  Hello world.

  ## Examples

      iex> Exinthegra.hello()
      :world

  """
  @spec call(:veiculos | :linhas | :paradas | :signin) :: {:error, binary} | {:ok, binary}
  def call(:veiculos), do: get("/veiculos") |> resp 
  def call(:linhas), do: get("/linhas") |> resp
  def call(:paradas), do: get("/paradas") |> resp

  @spec call(:linhas | :paradas | :paradas_linhas | :signin | :veiculos_linhas, binary) :: {:error, binary} | {:ok, binary}
  def call(:linhas, search), do: get("/linhas?busca=#{search}") |> resp
  def call(:paradas, search), do: get("/paradas?busca=#{search}") |> resp
  def call(:veiculos_linhas, search), do: get("/veiculosLinha?busca=#{search}") |> resp
  def call(:paradas_linhas, search), do: get("/paradasLinha?busca=#{search}") |> resp
  def call(_, _), do: raise "Action notfound!"
end

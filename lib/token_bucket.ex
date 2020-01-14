defmodule Exinthegra.BucketToken do

  @moduledoc """
    Bucket para armazenamento de token e de algumas
    informações do mesmo.
  """

  use Agent

  @doc """
  Inicializa um novo bucket para o token da api.
  """
  def start_link(_opts) do
    Agent.start_link(fn -> %{token: '', time: '', since: ''} end)
  end

  @doc """
  Recuperar o token amarzenado no bucket.
  """
  def get(bucket, key \\ :token) do
   Agent.get(bucket, &Map.get(&1, key))
  end

  @doc """
  Atualiza o token no bucket.
  """
  def update(bucket, token) do
    Agent.update(bucket, fn _map ->
      %{token: token.token, time: token.minutes, since: Timex.now}
    end )
  end

  @doc """
  Verifica se o token no bucket expirou.
  """
  def expired?(bucket) do
    time_limmit = Timex.shift(get(bucket, :since), minutes: get(bucket, :time))
    Timex.after?(Timex.now, time_limmit)
  end
end

defmodule Exinthegra.BucketTokenTest do
  use ExUnit.Case, async: true

  alias Exinthegra.BucketToken

  setup do
    {:ok, bucket} = BucketToken.start_link(%{algo: "asdfa"})
    {:ok, bucket: bucket}
  end

  test "O retorno deve ter três atributos, token, time e since", %{bucket: bucket} do
    assert BucketToken.get(bucket, :token)
    assert BucketToken.get(bucket, :time)
    assert BucketToken.get(bucket, :since)
  end

  test "O estado inicial deve ser um map com o attrs vazios", %{bucket: bucket} do
    assert BucketToken.get(bucket, :token) == ''
    assert BucketToken.get(bucket, :time)  == ''
    assert BucketToken.get(bucket, :since) == ''
  end

  test "Os atibutos deve ser atualizaveis", %{bucket: bucket} do
    token = %{token: "Lu8n90nt3s", minutes: 10}
    BucketToken.update(bucket, token)
    assert BucketToken.get(bucket) == token.token
  end

  test "O token não deve expirar antes do prazo", %{bucket: bucket} do
    token = %{token: "Lu8n90nt3s", minutes: 10}
    BucketToken.update(bucket, token)
    refute BucketToken.expired?(bucket)
  end

  @tag timeout: :infinity
  test "O token deve expirar depois do prazo", %{bucket: bucket} do
    token = %{token: "Lu8n90nt3s", minutes: 1}
    BucketToken.update(bucket, token)
    :timer.sleep(1200*60)
    assert BucketToken.expired?(bucket)
  end

end

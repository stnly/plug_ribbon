defmodule PlugRibbonTest do
  use ExUnit.Case, async: true
  use Plug.Test

  setup do
    Logger.disable(self())
    :ok
  end

  @ribbon_string ~s(<div class="plug-ribbon">)

  test "injects banner in dev environment" do
    Mix.env(:dev)
    conn = conn(:get, "/")
    |> put_resp_content_type("text/html")
    |> resp(200, "<html><body><h1>Phoenix</h1></body></html>")
    |> Plug.Ribbon.call([:dev, :test])
    |> send_resp()

    assert conn.status == 200
    assert to_string(conn.resp_body) =~ @ribbon_string
  end

  test "injects banner in test environment" do
    Mix.env(:test)
    conn = conn(:get, "/")
    |> put_resp_content_type("text/html")
    |> resp(200, "<html><body><h1>Phoenix</h1></body></html>")
    |> Plug.Ribbon.call([:test, :dev])
    |> send_resp()

    assert conn.status == 200
    assert to_string(conn.resp_body) =~ @ribbon_string
  end

  test "does not inject banner in prod environment" do
    Mix.env(:prod)
    conn = conn(:get, "/")
    |> put_resp_content_type("text/html")
    |> resp(200, "<html><body><h1>Phoenix</h1></body></html>")
    |> Plug.Ribbon.call([:test, :dev])
    |> send_resp()

    assert conn.status == 200
    refute to_string(conn.resp_body) =~ @ribbon_string
  end

  test "does not inject banner if html response missing body tag" do
    Mix.env(:dev)
    conn = conn(:get, "/")
    |> put_resp_content_type("text/html")
    |> resp(200, "<h1>Phoenix</h1>")
    |> Plug.Ribbon.call([:test, :dev])
    |> send_resp()

    assert conn.status == 200
    refute to_string(conn.resp_body) =~ @ribbon_string
  end

  test "does not inject banner if response is json" do
    Mix.env(:dev)
    conn = conn(:get, "/")
    |> put_resp_content_type("application/json")
    |> resp(200, "{}")
    |> Plug.Ribbon.call([:test, :dev])
    |> send_resp()

    assert conn.status == 200
    refute to_string(conn.resp_body) =~ @ribbon_string
  end
end

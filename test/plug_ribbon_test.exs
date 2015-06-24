defmodule PlugRibbonTest do
  use ExUnit.Case, async: true
  use Plug.Test

  setup do
    Logger.disable(self())
    :ok
  end

  test "injects banner" do
    conn = conn(:get, "/")
    |> put_resp_content_type("text/html")
    |> resp(200, "<html><body><h1>Phoenix</h1></body></html>")
    |> Plug.Ribbon.call([])
    |> send_resp()

    assert conn.status == 200
    assert to_string(conn.resp_body) =~ ~s(<a href="/">Development</a>)
  end

  test "does not inject banner if html response missing body tag" do
    conn = conn(:get, "/")
    |> put_resp_content_type("text/html")
    |> resp(200, "<h1>Phoenix</h1>")
    |> Plug.Ribbon.call([])
    |> send_resp()

    assert conn.status == 200
    refute to_string(conn.resp_body) =~ ~s(<a href="/">Development</a>)
  end

  test "does not inject banner if response is json" do
    conn = conn(:get, "/")
    |> put_resp_content_type("application/json")
    |> resp(200, "{}")
    |> Plug.Ribbon.call([])
    |> send_resp()

    assert conn.status == 200
    refute to_string(conn.resp_body) =~ ~s(<a href="/">Development</a>)
  end
end

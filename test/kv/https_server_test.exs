defmodule HttpsServerTest do
  use ExUnit.Case, async: true
  use Maru.Test, for: Router.Homepage

  test "/" do
    assert "{\"hello\":\"world\"}" == get("/") |> text_response
  end

  test "/id" do
    assert "{\"user\":\"hello\"}" == get("/hello") |> text_response
  end
end
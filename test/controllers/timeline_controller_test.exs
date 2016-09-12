defmodule Sabiah.TimelineControllerTest do
  use Sabiah.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Timeline"
  end
end

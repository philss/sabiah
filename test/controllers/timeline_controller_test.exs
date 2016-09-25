defmodule Sabiah.TimelineControllerTest do
  use Sabiah.ConnCase

  test "GET / connected", %{conn: conn} do
    conn = conn
           |> assign(:current_user, %Sabiah.User{id: 42, email: "example@email.com"})
           |> get("/")

    assert html_response(conn, 200) =~ "Tweet"
  end

  test "GET / disconnected", %{conn: conn} do
    conn = conn
           |> get("/")

    assert redirected_to(conn) == user_path(conn, :new)
  end
end

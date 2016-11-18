defmodule Sabiah.LayoutView do
  use Sabiah.Web, :view

  def get_user(conn) do
    conn.assigns[:current_user] || %Sabiah.User{}
  end

  def user_header(nil), do: ""
  def user_header(current_user) do
    render("_logged_user_header.html", %{user: current_user})
  end

  def get_gravatar_image(email) do
    hash = email
           |> :erlang.md5()
           |> Base.encode16(case: :lower)

    "//gravatar.com/avatar/#{hash}?d=retro"
  end
end

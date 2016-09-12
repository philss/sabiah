defmodule Sabiah.FollowerController do
  use Sabiah.Web, :controller

  alias Sabiah.{User, Follower}

  def create(conn, %{"follower" => params}) do
    user_id = get_session(conn, :user_id)

    params = Map.put(params, "user_id", user_id)
    changeset = Follower.changeset(%Follower{}, params)

    case Repo.insert(changeset) do
      {:ok, follow} ->
        conn
        |> put_flash(:info, "You are now following #{follow.followed_user_id}")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        IO.inspect(changeset)
        conn
        |> put_flash(:error, "You seems to be logged out. Create an user to continue.")
        |> redirect(to: user_path(conn, :new))
    end
  end
end

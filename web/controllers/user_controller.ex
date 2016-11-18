defmodule Sabiah.UserController do
  use Sabiah.Web, :controller

  alias Sabiah.User

  def index(conn, _params) do
    user = conn.assigns[:current_user]
    render(conn, "index.html", users: users_to_follow(user))
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> put_session(:user_id, user.id)
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  defp users_to_follow(nil), do: []
  defp users_to_follow(current_user) do
    following_query = from f in "followers",
                        where: f.user_id == ^current_user.id,
                        select: f.followed_user_id

    following = Repo.all(following_query)
    all_user_ids = Repo.all(from u in User, select: u.id)
    not_following = all_user_ids -- [current_user.id|following]
    Repo.all(from u in User, where: u.id in ^not_following)
  end
end

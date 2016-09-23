defmodule Sabiah.TimelineController do
  use Sabiah.Web, :controller

  alias Sabiah.{User, Tweet}

  def index(conn, _params) do
    user = conn.assigns[:current_user]

    if user do
      render(conn, "index.html", tweets: tweets_from_timeline(user))
    else
      redirect(conn, to: user_path(conn, :new))
    end
  end

  def show(conn, %{ "username" => "@" <> username }) do
    show(conn, %{ "username" => username })
  end
  def show(conn, %{ "username" => username }) do
    user = Repo.get_by(User, username: username)

    if user do
      tweets = Repo.all(from t in Tweet,
                        preload: [:user],
                        where: t.user_id == ^user.id, order_by: [desc: t.inserted_at])

      render(conn, "show.html", tweets: tweets, user: user)
    else
      render(conn, "404.html", username: username)
    end
  end

  defp tweets_from_timeline(user) do
    tweets_query = from t in Tweet,
                      join: tl in assoc(t, :timelines),
                      where: tl.user_id == ^user.id,
                      preload: [:user],
                      order_by: [desc: t.inserted_at],
                      limit: 42

    Repo.all(tweets_query)
  end
end

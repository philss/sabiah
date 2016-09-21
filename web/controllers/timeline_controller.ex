defmodule Sabiah.TimelineController do
  use Sabiah.Web, :controller

  alias Sabiah.{User, Tweet}

  def index(conn, _params) do
    user = conn.assigns[:current_user]

    if user do
      render(conn, "index.html", tweets: user_tweets(user))
    else
      redirect(conn, to: user_path(conn, :new))
    end
  end

  def show(conn, %{ "username" => "@" <> username }) do
    show(conn, %{"username" => username})
  end
  def show(conn, %{ "username" => username }) do
    user = Repo.get_by(User, username: username)

    if user do
      render(conn, "show.html", tweets: user_tweets(user), user: user)
    else
      render(conn, "404.html", username: username)
    end
  end

  defp user_tweets(user) do
    tweets_query = from t in Tweet,
                      join: tm in assoc(t, :timelines),
                      where: tm.user_id == ^user.id,
                      preload: [:user],
                      order_by: [desc: t.inserted_at],
                      limit: 42

    Repo.all(tweets_query)
  end
end

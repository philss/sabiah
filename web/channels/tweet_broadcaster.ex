defmodule Sabiah.TweetBroadcaster do
  alias Sabiah.{Endpoint, Repo}

  import Ecto.Query

  def broadcast(author_id, payload) do
    query = from f in "followers",
              where: f.followed_user_id == ^author_id,
              select: f.user_id
    query
    |> Repo.all
    |> Enum.map(fn(user_id) ->
      Endpoint.broadcast!("timeline:#{user_id}", "new_tweet", payload)
    end)
  end
end

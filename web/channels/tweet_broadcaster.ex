defmodule Sabiah.TweetBroadcaster do
  alias Sabiah.{Endpoint, Repo}

  import Ecto.Query

  def broadcast_to_followers(tweet, payload) do
    followers_ids_query = from f in "followers",
                            where: f.followed_user_id == ^tweet.user_id,
                            select: f.user_id
    followers_ids_query
    |> Repo.all
    |> Enum.map(fn(user_id) ->
      Endpoint.broadcast!("timeline:#{user_id}", "new_tweet", payload)
    end)
  end
end

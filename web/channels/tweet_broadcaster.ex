defmodule Sabiah.TweetBroadcaster do
  alias Sabiah.{Endpoint, Repo}

  import Ecto.Query

  def broadcast_to_followers(tweet, payload) do
    follower_ids = follower_user_ids(tweet)
    Repo.insert_all("timelines", timelines(tweet, follower_ids))

    Enum.map(follower_ids, fn(user_id) ->
      Endpoint.broadcast!("timeline:#{user_id}", "new_tweet", payload)
    end)
  end

  defp timelines(tweet, follower_ids) do
    Enum.map([tweet.user_id|follower_ids], fn(user_id) ->
      [user_id: user_id, tweet_id: tweet.id]
    end)
  end

  defp follower_user_ids(tweet) do
    followers_ids_query = from f in "followers",
                            where: f.followed_user_id == ^tweet.user_id,
                            select: f.user_id

    Repo.all(followers_ids_query)
  end
end

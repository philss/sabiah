defmodule Sabiah.TweetBroadcaster do
  alias Sabiah.{Endpoint, Repo}

  import Ecto.Query

  def broadcast_to_followers(tweet, payload) do
    follower_ids = follower_user_ids(tweet)

    # You can insert multiple values at once.
    # It translate into `INSERT INTO timelines(user_id, tweet_id) VALUES (1, 2), (2, 1);`
    Repo.insert_all("timelines", timelines(tweet, follower_ids))

    Enum.map(follower_ids, fn(user_id) ->
      Endpoint.broadcast!("timeline:#{user_id}", "new_tweet", payload)
    end)
  end

  # Here we also add the tweet author to the list of timelines that
  # gonna be saved.
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

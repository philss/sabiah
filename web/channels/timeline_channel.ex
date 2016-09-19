defmodule Sabiah.TimelineChannel do
  use Sabiah.Web, :channel
  alias Sabiah.{Repo, Tweet, User, TweetBroadcaster}

  def join("timeline:", _payload, _socket) do
    {:error, %{reason: "User id is missing."}}
  end
  def join("timeline:" <> user_id, _payload, socket) do
    socket = assign(socket, :user_id, user_id)
    {:ok, socket}
  end

  def handle_in("new_tweet", %{"content" => content}, socket) do
    user_id = socket.assigns[:user_id]
    tweet = save_tweet!(user_id, content)
    response_payload = decorate_payload(user_id, %{"content" => content})

    broadcast socket, "new_tweet", response_payload
    TweetBroadcaster.broadcast_to_followers(tweet, response_payload)

    {:noreply, socket}
  end

  defp decorate_payload(user_id, payload) do
    user = Repo.get(User, user_id)
    payload
    |> Map.put("name", user.name)
    |> Map.put("username", user.username)
  end

  defp save_tweet!(user_id, content) do
    tweet_changeset = Tweet.changeset(%Tweet{},
                                      %{user_id: user_id, content: content})
    Repo.insert!(tweet_changeset)
  end
end

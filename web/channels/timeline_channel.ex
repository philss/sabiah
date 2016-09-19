defmodule Sabiah.TimelineChannel do
  use Sabiah.Web, :channel
  alias Sabiah.{Repo, User, TweetBroadcaster}

  def join("timeline:", _payload, _socket) do
    {:error, %{reason: "User id is missing."}}
  end
  def join("timeline:" <> user_id, _payload, socket) do
    socket = assign(socket, :user_id, user_id)
    {:ok, socket}
  end

  def handle_in("new_tweet", payload, socket) do
    user = Repo.get(User, socket.assigns[:user_id])
    response_payload = payload
                       |> Map.put("name", user.name)
                       |> Map.put("username", user.username)

    broadcast socket, "new_tweet", response_payload
    TweetBroadcaster.broadcast(user.id, response_payload)

    {:noreply, socket}
  end
end

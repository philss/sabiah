defmodule Sabiah.TimelineChannelTest do
  use Sabiah.ChannelCase

  alias Sabiah.{TimelineChannel, Repo, User}

  setup do
    changeset = User.changeset(%User{}, %{username: "philss", name: "Philip", email: "phil@email"})
    user_id = case Repo.insert(changeset) do
                {:ok, user} -> user.id
                {:error, _} -> nil
              end

    {:ok, _, socket} =
      socket("user_id", %{some: :assign})
      |> subscribe_and_join(TimelineChannel, "timeline:#{user_id}")

    {:ok, socket: socket}
  end

  test "new_tweet broadcasts to timeline:42", %{socket: socket} do
    push socket, "new_tweet", %{"content" => "Hello world"}
    assert_broadcast "new_tweet", %{"content" => "Hello world",
                                    "username" => "philss", "name" => "Philip"}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from! socket, "broadcast", %{"some" => "data"}
    assert_push "broadcast", %{"some" => "data"}
  end
end

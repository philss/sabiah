defmodule Sabiah.TweetTest do
  use Sabiah.ModelCase

  alias Sabiah.Tweet

  @valid_attrs %{content: "some content", user_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Tweet.changeset(%Tweet{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Tweet.changeset(%Tweet{}, @invalid_attrs)
    refute changeset.valid?
  end
end

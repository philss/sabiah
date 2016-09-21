defmodule Sabiah.TimelineTest do
  use Sabiah.ModelCase

  alias Sabiah.Timeline

  @valid_attrs %{user_id: 42, tweet_id: 21}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Timeline.changeset(%Timeline{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Timeline.changeset(%Timeline{}, @invalid_attrs)
    refute changeset.valid?
  end
end

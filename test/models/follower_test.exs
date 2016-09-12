defmodule Sabiah.FollowerTest do
  use Sabiah.ModelCase

  alias Sabiah.Follower

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with invalid attributes" do
    changeset = Follower.changeset(%Follower{}, @invalid_attrs)
    refute changeset.valid?
  end
end

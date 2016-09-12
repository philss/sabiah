defmodule Sabiah.UserTest do
  use Sabiah.ModelCase

  alias Sabiah.User

  @valid_attrs %{email: "joana@email.com", name: "Joana", username: "joana"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end

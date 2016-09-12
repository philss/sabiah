defmodule Sabiah.UserView do
  use Sabiah.Web, :view

  alias Sabiah.Follower

  def follower_changeset(user_id) do
    Follower.changeset(%Follower{followed_user_id: user_id})
  end
end

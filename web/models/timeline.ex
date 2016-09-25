defmodule Sabiah.Timeline do
  use Sabiah.Web, :model

  schema "timelines" do
    belongs_to :user, Sabiah.User
    belongs_to :tweet, Sabiah.Tweet

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :tweet_id])
    |> validate_required([:user_id, :tweet_id])
  end
end

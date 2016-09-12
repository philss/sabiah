defmodule Sabiah.Follower do
  use Sabiah.Web, :model

  schema "followers" do
    field :user_id, :integer
    field :followed_user_id, :integer

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :followed_user_id])
    |> validate_required([:user_id, :followed_user_id])
  end
end

defmodule Sabiah.Tweet do
  use Sabiah.Web, :model

  schema "tweets" do
    field :content, :string

    belongs_to :user, Sabiah.User
    has_many :timelines, Sabiah.Timeline

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :content])
    |> validate_required([:user_id, :content])
  end
end

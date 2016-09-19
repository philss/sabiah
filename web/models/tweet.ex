defmodule Sabiah.Tweet do
  use Sabiah.Web, :model

  schema "tweets" do
    field :content, :string
    belongs_to :user, Sabiah.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content])
    |> validate_required([:content])
  end
end

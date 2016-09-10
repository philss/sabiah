defmodule Sabiah.User do
  use Sabiah.Web, :model

  schema "users" do
    field :name, :string
    field :username, :string
    field :email, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :username, :email])
    |> validate_required([:name, :username, :email])
  end
end

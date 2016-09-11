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
    |> validate_format(:email, ~r/@/)
    |> validate_format(:username, ~r/^[a-zA-Z0-9_-]+$/)
    |> validate_length(:username, min: 3, max: 42)
  end
end

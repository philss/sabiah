defmodule Sabiah.Repo.Migrations.CreateTweet do
  use Ecto.Migration

  def change do
    create table(:tweets) do
      add :content, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:tweets, [:user_id])

  end
end

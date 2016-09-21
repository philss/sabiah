defmodule Sabiah.Repo.Migrations.CreateTimeline do
  use Ecto.Migration

  def change do
    create table(:timelines) do
      add :user_id, references(:users, on_delete: :nothing)
      add :tweet_id, references(:tweets, on_delete: :nothing)

      timestamps()
    end
    create index(:timelines, [:user_id])
    create index(:timelines, [:tweet_id])

  end
end

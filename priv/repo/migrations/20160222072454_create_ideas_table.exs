defmodule Ideatap.Repo.Migrations.CreateIdeasTable do
  use Ecto.Migration

  def change do
    create table(:ideas) do
      add :title, :string
      add :description, :text
      add :slug, :string
      add :user_id, references(:users)

      timestamps
    end

    create unique_index(:ideas, [:slug])
  end
end

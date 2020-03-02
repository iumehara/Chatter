defmodule Chatter.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :content, :string
      add :group_id, references(:groups, type: :binary_id)

      timestamps()
    end

  end
end

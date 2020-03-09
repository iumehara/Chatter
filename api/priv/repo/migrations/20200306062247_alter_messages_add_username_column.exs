defmodule Chatter.Repo.Migrations.AlterMessagesAddUsernameColumn do
  use Ecto.Migration

  def change do
    alter table("messages") do
      add :username, :string
    end
  end
end

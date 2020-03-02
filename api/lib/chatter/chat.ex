defmodule Chatter.Chat do
  import Ecto.Query, warn: false
  alias Chatter.Repo
  alias Chatter.Chat.Group

  def list_groups do
    Repo.all(Group)
  end

  def get_group!(id), do: Repo.get!(Group, id)

  def create_group(attrs \\ %{}) do
    %Group{}
    |> Group.changeset(attrs)
    |> Repo.insert()
  end
end

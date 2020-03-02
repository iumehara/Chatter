defmodule Chatter.ChatTest do
  use Chatter.DataCase

  alias Chatter.Chat

  describe "groups" do
    alias Chatter.Chat.Group

    @valid_attrs %{name: "some name"}
    @invalid_attrs %{name: nil}

    def group_fixture(attrs \\ %{}) do
      {:ok, group} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Chat.create_group()

      group
    end

    test "list_groups/0 returns all groups" do
      group = group_fixture()
      assert Chat.list_groups() == [group]
    end

    test "get_group!/1 returns the group with given id" do
      group = group_fixture()
      assert Chat.get_group!(group.id) == group
    end

    test "create_group/1 with valid data creates a group" do
      assert {:ok, %Group{} = group} = Chat.create_group(@valid_attrs)
      assert group.name == "some name"
    end

    test "create_group/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_group(@invalid_attrs)
    end
  end
end

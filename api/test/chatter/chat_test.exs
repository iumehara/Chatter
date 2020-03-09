defmodule Chatter.ChatTest do
  use Chatter.DataCase
  alias Chatter.Chat
  alias Chatter.Chat.Message

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
      [
        %Group{
          id: group_id,
          name: "some name"
        }
      ] = Chat.list_groups()

      assert group_id == group.id
    end

    test "get_group!/1 returns the group with given id" do
      group = group_fixture()
      {:ok, message} = Chat.create_message(%{content: "first message", username: "Amy", group_id: group.id})
      assert %Group{
               id: group_id,
               name: "some name",
               messages: [
                 %Message{
                   id: message_id,
                   username: "Amy",
                   content: "first message"
                 }
               ]
             } = Chat.get_group!(group.id)
      assert group_id == group.id
      assert message_id == message.id
    end

    test "create_group/1 with valid data creates a group" do
      assert {:ok, %Group{} = group} = Chat.create_group(@valid_attrs)
      assert group.name == "some name"
    end

    test "create_group/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_group(@invalid_attrs)
    end
  end

  describe "messages" do
    alias Chatter.Chat.Message

    @valid_attrs %{content: "some content", username: "Amy"}
    @invalid_attrs %{content: nil}

    def message_fixture(attrs \\ %{}) do
      group = group_fixture()
      {:ok, message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Enum.into(%{group_id: group.id})
        |> Chat.create_message()

      message
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Chat.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      group = group_fixture()
      assert {
               :ok,
               %Message{} = message
             } = Chat.create_message(%{content: "some content", username: "Amy", group_id: group.id})
      assert message.content == "some content"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_message(@invalid_attrs)
    end
  end
end

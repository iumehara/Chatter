defmodule ChatterWeb.GroupChannelTest do
  use ChatterWeb.ChannelCase

  setup do
    {:ok, _, socket} =
      socket(ChatterWeb.UserSocket, "user_id", %{some: :assign})
      |> subscribe_and_join(ChatterWeb.GroupChannel, "group:lobby")

    {:ok, socket: socket}
  end

  test "ping replies with status ok", %{socket: socket} do
    ref = push socket, "ping", %{"hello" => "there"}
    assert_reply ref, :ok, %{"hello" => "there"}
  end

  test "shout broadcasts to group:group_id", %{socket: socket} do
    {:ok, group} = Chatter.Chat.create_group(%{name: "test group"})
    push socket,
         "shout",
         %{
           "body" => %{
             "content" => "hi there",
             "username" => "Amy",
             "groupId" => group.id
           }
         }
    assert_broadcast "shout",
                     %{
                       "body" => %{
                         "content" => "hi there",
                         "id" => message_id,
                         "username" => "Amy"
                       }
                     }
end

test "broadcasts are pushed to the client", %{socket: socket} do
                                                              broadcast_from! socket, "broadcast", %{"some" => "data"}
                                                                                                      assert_push "broadcast", %{"some" => "data"}
                                                              end
end

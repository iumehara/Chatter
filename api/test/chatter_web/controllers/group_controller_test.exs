defmodule ChatterWeb.GroupControllerTest do
  use ChatterWeb.ConnCase

  alias Chatter.Chat

  @create_attrs %{
    name: "some name"
  }
  @invalid_attrs %{name: nil}

  def fixture(:group) do
    {:ok, group} = Chat.create_group(@create_attrs)
    group
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all groups", %{conn: conn} do
      conn = get(conn, Routes.group_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "show" do
    test "renders a group with associated members", %{conn: conn} do
      {:ok, group} = Chat.create_group(%{name: "test name"})
      {:ok, message} = Chat.create_message(%{content: "first message", group_id: group.id})

      conn = get(conn, Routes.group_path(conn, :show, group.id))

      assert %{
               "id" => group_id,
               "name" => "test name",
               "messages" => [
                 %{
                   "id" => message_id,
                   "content" => "first message"
                 }
               ]
             } = json_response(conn, 200)["data"]
      assert group_id == group.id
      assert message_id == message.id
    end
  end

  describe "create group" do
    test "renders group when data is valid", %{conn: conn} do
      conn = post(conn, Routes.group_path(conn, :create), group: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.group_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.group_path(conn, :create), group: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end

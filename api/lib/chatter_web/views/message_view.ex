defmodule ChatterWeb.MessageView do
  use ChatterWeb, :view

  def render("message.json", %{message: message}) do
    %{id: message.id,
      content: message.content,
      username: message.username}
  end

  def to_payload(message) do
    %{
      "body" => %{
        "id" => message.id,
        "content" => message.content,
        "username" => message.username
      }
    }
  end

  def from_payload(%{"body" => body}) do
    %{
      "content" => body["content"],
      "username" => body["username"],
      "group_id" => body["groupId"]
    }
  end
end

defmodule ChatterWeb.GroupChannel do
  use ChatterWeb, :channel
  alias Chatter.Chat
  alias Chatter.Chat.Message
  alias ChatterWeb.MessageView

  def join("group:" <> _group_id, payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (group:lobby).
  def handle_in("shout", payload, socket) do
    with {:ok, message} = Chat.create_message(MessageView.from_payload(payload)) do
      broadcast socket, "shout", MessageView.to_payload(message)
    end

    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end

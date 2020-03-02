defmodule ChatterWeb.MessageView do
  use ChatterWeb, :view

  def render("message.json", %{message: message}) do
    %{id: message.id,
      content: message.content}
  end
end

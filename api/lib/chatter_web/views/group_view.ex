defmodule ChatterWeb.GroupView do
  use ChatterWeb, :view
  alias ChatterWeb.GroupView
  alias ChatterWeb.MessageView

  def render("index.json", %{groups: groups}) do
    %{data: render_many(groups, GroupView, "group.json")}
  end

  def render("show.json", %{group: group}) do
    %{data: render_one(group, GroupView, "group_details.json")}
  end

  def render("group.json", %{group: group}) do
    %{id: group.id,
      name: group.name}
  end

  def render("group_details.json", %{group: group}) do
    %{id: group.id,
      name: group.name,
      messages: render_many(group.messages, MessageView, "message.json")}
  end
end

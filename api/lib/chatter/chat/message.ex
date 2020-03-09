defmodule Chatter.Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "messages" do
    field :content, :string
    field :username, :string

    timestamps()

    belongs_to :group, Chatter.Chat.Group
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:content, :username, :group_id])
    |> validate_required([:content, :username, :group_id])
  end
end

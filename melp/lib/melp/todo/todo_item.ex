defmodule Melp.Todo.TodoItem do
  use Ecto.Schema
  import Ecto.Changeset
  import Geo
  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "todo_items" do

    field :city, :string
    field :email, :string
    field :lat, :float
    field :lng, :float
    field :name, :string
    field :phone, :string
    field :rating, :integer
    field :site, :string
    field :state, :string
    field :street, :string
    field :coordinates, Geo.PostGIS.Geometry

    timestamps()
  end

  @doc false
  def changeset(todo_item, attrs) do
    todo_item
    |> cast(attrs, [:rating, :name, :site, :email, :phone, :street, :city, :state, :lat, :lng, :coordinates])
    |> validate_required([:name, :lat, :lng])
  end
end

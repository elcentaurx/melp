defmodule Melp.Repo.Migrations.CreateTodoItems do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS postgis"

    create table(:todo_items) do
      add :rating, :integer
      add :name, :string
      add :site, :string
      add :email, :string
      add :phone, :string
      add :street, :string
      add :city, :string
      add :state, :string
      add :lat, :float
      add :lng, :float
      add :coordinates, :geometry


      timestamps()
    end
  end
end

defmodule Melp.TodoFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Melp.Todo` context.
  """

  @doc """
  Generate a todo_item.
  """
  def todo_item_fixture(attrs \\ %{}) do
    {:ok, todo_item} =
      attrs
      |> Enum.into(%{
        city: "some city",
        email: "some email",
        lat: 120.5,
        lng: 120.5,
        name: "some name",
        phone: "some phone",
        rating: 42,
        site: "some site",
        state: "some state",
        street: "some street"
      })
      |> Melp.Todo.create_todo_item()

    todo_item
  end
end

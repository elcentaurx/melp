defmodule MelpWeb.RestaurantLocateController do
  use MelpWeb, :controller

  alias Melp.Todo

  def index(conn, _params) do
    json put_status(conn, :ok), "Ok"
  end

  def get_restaurants(conn, %{"lat" => latitude, "lng" => longitude, "radius" => radius}) do
    Todo.get_restaurants(latitude, longitude, radius)
    |> case do
      {:ok, data} ->
        data |> IO.inspect(label: "========================>")
        json put_status(conn, :ok), %{"message" => "se encontró información"}
      {:error, _} ->
        json put_status(conn, :ok), %{"message" => "No pudo encotrarse información"}
    end
  end

  end

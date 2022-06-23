defmodule MelpWeb.PageController do
  use MelpWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

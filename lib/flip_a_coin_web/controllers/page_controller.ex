defmodule FlipACoinWeb.PageController do
  use FlipACoinWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

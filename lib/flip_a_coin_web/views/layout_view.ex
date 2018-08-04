defmodule FlipACoinWeb.LayoutView do
  use FlipACoinWeb, :view

  def socket_url, do: System.get_env("WEBSOCKET_URL") || "ws://localhost:4000/socket/websocket"
end

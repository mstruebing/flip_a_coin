defmodule FlipACoinWeb.FlipACoinChannel do
  use FlipACoinWeb, :channel

  alias FlipACoin.Flip

  require Logger

  def join("flip_a_coin", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Used to flip a coin
  def handle_in("flip", _payload, socket) do
    flip = flip()

    spawn(fn -> saveFlip(flip) end)
    shoutStatistics(socket)

    {:reply, {:ok, %{:coinStatus => flip}}, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (flip_a_coin:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Shouts statistics to every connected socket
  defp shoutStatistics(socket) do
    broadcast socket, "shout:statistics", 
    %{
      :total => Flip.get_flips(), 
      :heads => Flip.get_heads(), 
      :tails => Flip.get_tails()
    }
  end

  # Saves the flip to the database as string
  defp saveFlip(flip) do
    FlipACoin.Flip.changeset(
      %FlipACoin.Flip{}, 
      %{:result => Atom.to_string(flip)})
    |> FlipACoin.Repo.insert
  end

  # Generates random :Head or :Tails
  defp flip do
    case Enum.random(0..1)  do
       0 -> :Head
       1 -> :Tails
    end
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end

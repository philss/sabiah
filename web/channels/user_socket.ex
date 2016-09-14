defmodule Sabiah.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "timeline:*", Sabiah.TimelineChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket
  # transport :longpoll, Phoenix.Transports.LongPoll

  # Socket connection
  def connect(_params, socket) do
    {:ok, socket}
  end

  ## Socket id
  def id(_socket), do: nil
end

defmodule Sabiah.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "timeline:*", Sabiah.TimelineChannel

  ## Transports
  # NOTE: timeout should be less than 55_000 for production
  transport :websocket, Phoenix.Transports.WebSocket,
    timeout: 45_000
  # transport :longpoll, Phoenix.Transports.LongPoll

  # Socket connection
  def connect(_params, socket) do
    {:ok, socket}
  end

  ## Socket id
  def id(_socket), do: nil
end

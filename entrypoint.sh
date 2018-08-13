#!/usr/bin/env sh

export MIX_ENV=prod 
export PORT=4000
export WEBSOCKET_URL=wss://flip.maex.me/socket/websocket

cd /app 
mix ecto.migrate
mix compile
mix phx.digest
mix phx.server

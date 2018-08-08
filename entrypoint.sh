#!/usr/bin/env sh

export MIX_ENV=prod 
export PORT=4000
export WEBSOCKET_URL=wss://flip.maex.me/socket/websocket
export SSL_KEY_PATH=/app/fullchain.pem
export SSL_CERT_PATH=/app/privkey.pem

cd /app 
mix ecto.migrate  
mix compile 
mix phx.digest
mix phx.server

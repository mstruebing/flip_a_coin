module Subscriptions exposing (subscriptions)

import Phoenix
import Phoenix.Channel as Channel exposing (Channel)
import Phoenix.Socket as Socket exposing (Socket)
import Types exposing (Model, Msg(..))


subscriptions : Model -> Sub Msg
subscriptions model =
    Phoenix.connect (socket model.flags.socketUrl) [ contacts ]


socket : String -> Socket Msg
socket socketUrl =
    Socket.init socketUrl


contacts : Channel Msg
contacts =
    Channel.init "flip_a_coin"
        |> Channel.on "shout:statistics" GetStatistics
        |> Channel.withDebug

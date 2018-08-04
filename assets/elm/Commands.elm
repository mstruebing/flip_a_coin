module Commands exposing (ping)

import Json.Encode as JE
import Phoenix exposing (..)
import Phoenix.Push as Push
import Types exposing (Msg(..))


ping : String -> Cmd Msg
ping socketUrl =
    let
        payload =
            JE.object
                []

        push =
            Push.init "room" "room:ping"
                |> Push.withPayload payload
                |> Push.onOk PingSuccess
                |> Push.onError PingError
    in
    Phoenix.push socketUrl push

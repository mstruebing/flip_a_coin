module Commands exposing (flip)

import Json.Encode as JE
import Phoenix exposing (..)
import Phoenix.Push as Push
import Types exposing (Msg(..))


flip : String -> Cmd Msg
flip socketUrl =
    let
        payload =
            JE.object
                []

        push =
            Push.init "flip_a_coin" "flip"
                |> Push.withPayload payload
                |> Push.onOk FlipSuccess
                |> Push.onError FlipError
    in
    Phoenix.push socketUrl push

module Update exposing (update)

import Commands as C exposing (flip)
import Types exposing (Model, Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Flip ->
            ( model, C.flip model.flags.socketUrl )

        FlipSuccess message ->
            let
                x =
                    Debug.log "message" message
            in
            ( model, Cmd.none )

        FlipError _ ->
            ( model, Cmd.none )

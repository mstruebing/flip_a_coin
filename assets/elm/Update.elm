module Update exposing (update)

import Commands exposing (ping)
import Modules.User as User
import Navigation as Navigation
import Routing exposing (parse, toPath)
import Types exposing (Model, Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Noop ->
            ( model, Cmd.none )

        UrlChange location ->
            let
                currentRoute =
                    parse location
            in
            ( { model | route = currentRoute }, Cmd.none )

        NavigateTo route ->
            ( model, Cmd.batch [ Navigation.newUrl <| toPath route, ping model.flags.socketUrl ] )

        UserMsg userMsg ->
            let
                ( updatedModel, cmd ) =
                    User.update userMsg model.userModel
            in
            ( { model | userModel = updatedModel }, Cmd.map UserMsg cmd )

        PingSuccess _ ->
            ( model, Cmd.none )

        PingError _ ->
            ( model, Cmd.none )

module Main exposing (..)

import Modules.User as User
import Navigation exposing (Location)
import Routing exposing (Route(..), parse, toPath)
import Subscriptions exposing (subscriptions)
import Types exposing (Flags, Model, Msg(..))
import Update exposing (update)
import View exposing (view)


init : Flags -> Navigation.Location -> ( Model, Cmd Msg )
init flags location =
    let
        currentRoute =
            parse location
    in
    initialModel flags currentRoute


initialModel : Flags -> Route -> ( Model, Cmd Msg )
initialModel flags route =
    ( { userModel = User.initialModel flags.socketUrl
      , route = route
      , flags = flags
      }
    , Cmd.none
    )


main : Program Flags Model Msg
main =
    Navigation.programWithFlags UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- VIEW

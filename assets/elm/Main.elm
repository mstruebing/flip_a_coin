module Main exposing (..)

import Html exposing (Html)
import Subscriptions exposing (subscriptions)
import Types exposing (CoinStatus(..), Flags, Model, Msg(..))
import Update exposing (update)
import View exposing (view)


init : Flags -> ( Model, Cmd Msg )
init flags =
    initialModel flags


initialModel : Flags -> ( Model, Cmd Msg )
initialModel flags =
    ( { flags = flags
      , coinStatus = Head
      , statistics =
            { heads = 0
            , tails = 0
            , total = 0
            }
      , errorMsg = ""
      }
    , Cmd.none
    )


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

module Types exposing (CoinStatus(..), Flags, Model, Msg(..))

import Json.Encode as JE


type alias Model =
    { flags : Flags
    , coinStatus : CoinStatus
    }


type CoinStatus
    = Head
    | Tail


type alias Flags =
    { socketUrl : String }


type Msg
    = Flip
    | FlipSuccess JE.Value
    | FlipError JE.Value

module Types exposing (CoinStatus(..), Flags, Model, Msg(..), Statistics)

import Json.Encode as JE


type alias Model =
    { flags : Flags
    , coinStatus : CoinStatus
    , statistics : Statistics
    , errorMsg : String
    }


type alias Statistics =
    { heads : Int
    , tails : Int
    , total : Int
    }


type CoinStatus
    = Head
    | Tails


type alias Flags =
    { socketUrl : String }


type Msg
    = Flip
    | FlipSuccess JE.Value
    | FlipError JE.Value
    | GetStatistics JE.Value

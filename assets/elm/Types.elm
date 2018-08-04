module Types exposing (Flags, Model, Msg(..))

import Json.Encode as JE
import Modules.User as User
import Navigation exposing (Location)
import Routing exposing (Route)


type alias Model =
    { userModel : User.Model
    , route : Route
    , flags : Flags
    }


type alias Flags =
    { socketUrl : String }


type Msg
    = Noop
    | UrlChange Location
    | NavigateTo Route
    | UserMsg User.Msg
    | PingSuccess JE.Value
    | PingError JE.Value

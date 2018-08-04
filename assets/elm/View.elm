module View exposing (view)

import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Types exposing (Model, Msg(..))


view : Model -> Html Msg
view model =
    div [ class "page", onClick Flip ]
        [ text <| toString model.coinStatus ]

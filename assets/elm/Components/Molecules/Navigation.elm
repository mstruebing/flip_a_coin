module Components.Molecules.Navigation exposing (navigation)

import Components.Atoms.Button exposing (button)
import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Routing exposing (Route(..))
import Types exposing (Msg(..))


navigation : List ( Route, String ) -> Html Msg
navigation routes =
    List.map
        (\route ->
            button
                [ Tuple.first route
                    |> NavigateTo
                    |> onClick
                ]
                [ Tuple.second route
                    |> text
                ]
        )
        routes
        |> div [ class "navigation" ]

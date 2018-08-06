module View exposing (view)

import Html exposing (Html, button, div, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Types exposing (Model, Msg(..))


view : Model -> Html Msg
view model =
    div [ class "app" ]
        [ printFlipButton
        , printCoinStatus model
        , printStatistics model
        ]


printFlipButton : Html Msg
printFlipButton =
    button
        [ onClick Flip
        , class "flipButton"
        ]
        [ text "Flip! (click)" ]


printCoinStatus : Model -> Html Msg
printCoinStatus { coinStatus } =
    div [ class "coinStatus" ]
        [ coinStatus
            |> toString
            |> text
        ]


printStatistics : Model -> Html Msg
printStatistics { statistics } =
    div [ class "statistics" ]
        [ div [] [ statistics.total |> toString |> (++) "total flips: " |> text ]
        , div [] [ statistics.heads |> toString |> (++) "heads: " |> text ]
        , div [] [ statistics.tails |> toString |> (++) "tails: " |> text ]
        ]

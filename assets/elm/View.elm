module View exposing (view)

import Components.Molecules.Navigation exposing (navigation)
import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Modules.User as User
import Routing exposing (Route(..))
import Types exposing (Model, Msg(..))


navigationItems : List ( Route, String )
navigationItems =
    [ ( IndexRoute, "Home" )
    , ( LoginRoute, "Login" )
    , ( RegisterRoute, "Register" )
    ]


view : Model -> Html Msg
view model =
    div [ class "page" ]
        [ navigation navigationItems
        , case model.route of
            IndexRoute ->
                div [ class "elm-app", onClick <| NavigateTo RegisterRoute ]
                    [ text "INDEX"
                    ]

            LoginRoute ->
                div [ class "elm-app" ]
                    [ Html.map UserMsg (User.loginView model.userModel)
                    ]

            RegisterRoute ->
                div [ class "elm-app" ]
                    [ Html.map UserMsg (User.registerView model.userModel)
                    ]

            NotFoundRoute ->
                div [ class "elm-app" ]
                    [ text "NOT FOUND"
                    ]
        ]

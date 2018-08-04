module Modules.User exposing (Model, Msg(..), initialModel, loginView, registerView, update)

import Components.Atoms.Button exposing (button)
import Html exposing (Html, div, form, input, text)
import Html.Attributes exposing (class, placeholder, type_)
import Html.Events exposing (onInput, onSubmit)
import Json.Encode as JE
import Phoenix exposing (..)
import Phoenix.Push as Push


type alias Model =
    { email : String
    , password : String
    , passwordConfirmation : String
    , isLoggedIn : Bool
    , socketUrl : String
    }


initialModel : String -> Model
initialModel socketUrl =
    { email = ""
    , password = ""
    , passwordConfirmation = ""
    , isLoggedIn = False
    , socketUrl = socketUrl
    }


type Msg
    = UpdatePassword String
    | UpdatePasswordConfirmation String
    | UpdateEmail String
    | SubmitLogin
    | SubmitRegister
    | LoginSuccess JE.Value
    | LoginError JE.Value
    | RegisterSuccess JE.Value
    | RegisterError JE.Value
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        UpdatePassword password ->
            ( { model | password = password }, Cmd.none )

        UpdatePasswordConfirmation password ->
            ( { model | passwordConfirmation = password }, Cmd.none )

        UpdateEmail email ->
            ( { model | email = email }, Cmd.none )

        SubmitLogin ->
            ( model, Cmd.batch [ login model.socketUrl model.email model.password ] )

        SubmitRegister ->
            ( model, Cmd.batch [ register model.socketUrl model.email model.password ] )

        LoginSuccess _ ->
            ( { model | isLoggedIn = True }, Cmd.none )

        LoginError _ ->
            ( model, Cmd.none )

        RegisterSuccess _ ->
            ( model, Cmd.none )

        RegisterError _ ->
            ( model, Cmd.none )


login : String -> String -> String -> Cmd Msg
login socketUrl email password =
    let
        payload =
            JE.object
                [ ( "email", JE.string email )
                , ( "password", JE.string password )
                ]

        push =
            Push.init "room" "room:user:login"
                |> Push.withPayload payload
                |> Push.onOk LoginSuccess
                |> Push.onError LoginError
    in
    Phoenix.push socketUrl push


register : String -> String -> String -> Cmd Msg
register socketUrl email password =
    let
        payload =
            JE.object
                [ ( "email", JE.string email )
                , ( "password", JE.string password )
                ]

        push =
            Push.init "room" "room:user:register"
                |> Push.withPayload payload
                |> Push.onOk RegisterSuccess
                |> Push.onError RegisterError
    in
    Phoenix.push socketUrl push


loginView : Model -> Html Msg
loginView model =
    div [ class "user__login" ]
        [ form
            [ onSubmit SubmitLogin ]
            [ input [ type_ "email", onInput UpdateEmail, placeholder "email" ] []
            , input [ type_ "password", onInput UpdatePassword, placeholder "password" ] []
            , button [ type_ "submit" ] [ text "Login" ]
            ]
        ]


registerView : Model -> Html Msg
registerView model =
    div [ class "user__register" ]
        [ form
            [ onSubmit SubmitRegister ]
            [ input [ type_ "email", onInput UpdateEmail, placeholder "email" ] []
            , input [ type_ "password", onInput UpdatePassword, placeholder "password" ] []
            , input [ type_ "password", onInput UpdatePasswordConfirmation, placeholder "confirm password" ] []
            , button [ type_ "submit", class "user__register__button" ] [ text "Login" ]
            ]
        ]

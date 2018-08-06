module Update exposing (update)

import Commands as C exposing (flip)
import Json.Decode as JD exposing (Decoder)
import Types exposing (CoinStatus(..), Model, Msg(..), Statistics)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Flip ->
            ( model, C.flip model.flags.socketUrl )

        FlipSuccess result ->
            let
                maybeCoinStatus =
                    JD.decodeValue coinStatusDecoder result
            in
            case maybeCoinStatus of
                Ok coinStatus ->
                    ( { model | coinStatus = coinStatus }, Cmd.none )

                Err err ->
                    ( { model | errorMsg = toString err }, Cmd.none )

        FlipError err ->
            ( { model | errorMsg = toString err }, Cmd.none )

        PrintStatistics result ->
            let
                maybeStatistics =
                    JD.decodeValue statisticsDecoder result
            in
            case maybeStatistics of
                Ok statistics ->
                    ( { model | statistics = statistics }, Cmd.none )

                Err err ->
                    ( { model | errorMsg = toString err }, Cmd.none )


statisticsDecoder : Decoder Statistics
statisticsDecoder =
    JD.map3 Statistics
        (JD.field "heads" JD.int)
        (JD.field "tails" JD.int)
        (JD.field "total" JD.int)


coinStatusFromString : String -> Decoder CoinStatus
coinStatusFromString string =
    case string of
        "Head" ->
            JD.succeed Head

        "Tails" ->
            JD.succeed Tails

        _ ->
            JD.fail ("Invalid coinStatus" ++ string)


coinStatusDecoder : Decoder CoinStatus
coinStatusDecoder =
    JD.field "coinStatus" JD.string |> JD.andThen coinStatusFromString

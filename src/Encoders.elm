module Encoders exposing (..)

import Json.Encode exposing (..)

import Game.Model exposing (..)


encodeObject : Value -> String
encodeObject object =
    encode 4 object


encodePlay : GameId -> Player -> Action -> String
encodePlay gameId player action=
    object
        [ ("mode", string "play")
        , ("gameId", string gameId)
        , ("player", string player)
        , ("action", encodeAction action)
        ]
    |> encodeObject

encodeAction : Action -> Value
encodeAction action =
    case action of
        NoAction ->
            null
        ChooseGameType gameType ->
            encodeGameType gameType
        PlayCard card ->
            object 
            [ ("color", string card.color)
            , ("number", string card.number)
            ]
encodeGameType : GameType -> Value
encodeGameType gameType =
    case gameType of
        NoGameType ->
            null
        Swap ->
            string "swap"
        Up ->
            string "up"
        Down ->
            string "down"
        Color color ->
            string color

encodeWatch : GameId -> Player -> GameCoord -> String
encodeWatch gameId player (round, turn) =
    object 
        [ ("mode", string "watch")
        , ("gameId", string gameId)
        , ("player", string player)
        , ("round", int round)
        , ("turn", int turn)
        ]
    |> encodeObject

encodeLobby : Player -> String
encodeLobby player =
    object
        [ ("mode", string "lobby")
        , ("player", string player)
        ]
    |> encodeObject


encodeInit : Player -> String
encodeInit player =
    object
        [ ("mode", string "init")
        , ("player", string player)
        ]
    |> encodeObject
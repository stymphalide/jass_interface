module Encoders exposing (..)
{-
    @moduledoc
    Encodes elm data into json strings.
-}

-- The functionality to encode elm Values into Strings.
import Json.Encode exposing (..)

import Game.Model exposing (..)

-- An object is always encoded with four spaces (To be readable)
encodeObject : Value -> String
encodeObject object =
    encode 4 object

-- Whenever a Action is made (e.g. clicking on a card)
-- it is encoded here
encodePlay : GameId -> Player -> Action -> String
encodePlay gameId player action=
    object
        [ ("mode", string "play")
        , ("gameId", string gameId)
        , ("player", string player)
        , ("action", encodeAction action)
        ]
    |> encodeObject
-- Here are the actions encoded. e.g. Cards that are played.
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
-- Helper for encodeAction in the first round when a gameType needs to be chosen.
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
-- encodes a new position in a game that is being watched. (e.g. 4  pl_1 (4,5))
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
-- Encodes the player that has joined the lobby.
encodeLobby : Player -> String
encodeLobby player =
    object
        [ ("mode", string "lobby")
        , ("player", string player)
        ]
    |> encodeObject

-- Encodes the player that has logged in.
encodeInit : Player -> String
encodeInit player =
    object
        [ ("mode", string "init")
        , ("player", string player)
        ]
    |> encodeObject
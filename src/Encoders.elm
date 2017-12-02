module Encoders exposing (..)

import Json.Encode exposing (..)

import Game.Model exposing (GameId, Player, GameCoord)


encodeObject : Value -> String
encodeObject object =
    encode 4 object


encodePlay : GameId -> Player -> String
encodePlay gameId player =
    object
        [ ("mode", string "play")
        , ("gameId", string gameId)
        , ("player", string player)
        ]
    |> encodeObject

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
module Msgs exposing (..)

import Window exposing (Size)

import Models exposing (Mode)

import Game.Model exposing (Player, GameId, GameCoord)

type Msg
    = OnLocationChange Mode
    | PlayerChange InputUpdate
    | InitUpdate String
    | FetchGame (Maybe GameCoord) (Maybe Player)
    | GameIdUpdate GameId
    | GameUpdate String
    | LobbyUpdate String
    | SizeUpdated Size

type InputUpdate 
    = Update String
    | Approve
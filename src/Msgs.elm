module Msgs exposing (..)

import Window exposing (Size)

import Models exposing (Route)

import Game.Model exposing (Player, GameId)

type Msg
    = OnLocationChange Route
    | PlayerChange InputUpdate
    | GameUpdate String
    | FetchGame (Int, Int) Player GameId Bool
    | GameIdUpdate GameId
    | SizeUpdated Size

type InputUpdate 
    = Update String
    | Approve
module Msgs exposing (..)

import Navigation exposing (Location)
import Window exposing (Size)

import Game.Model exposing (Player, GameId)

type Msg
    = OnLocationChange Location
    | PlayerChange InputUpdate
    | GameUpdate String
    | FetchGame (Int, Int) Player GameId Bool
    | GameIdUpdate GameId
    | SizeUpdated Size

type InputUpdate 
    = Update String
    | Approve
module Msgs exposing (..)

import Navigation exposing (Location)
import Window exposing (Size)

import Game.Model exposing (Player)

type Msg
    = OnLocationChange Location
    | GameUpdate String 
    | FetchGame (Int, Int) Player
    | SizeUpdated Size

module Msgs exposing (..)

import Navigation exposing (Location)

type Msg
    = OnLocationChange Location
    | GameUpdate String
    | Send 

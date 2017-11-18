module Msgs exposing (..)

import Navigation exposing (Location)
import Window exposing (Size)

type Msg
    = OnLocationChange Location
    | GameUpdate String 
    | Send
    | SizeUpdated Size

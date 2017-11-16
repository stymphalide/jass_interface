module Game.Update exposing (..)

import Game.Model exposing (Game)
import Decoders exposing (gameDecoder)


updateGame : String -> Maybe String
updateGame gameString =
    Just gameString

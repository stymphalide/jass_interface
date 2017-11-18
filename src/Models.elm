module Models exposing (..)

import Window exposing (Size)
import Game.Model exposing (Game)


type Route
    = Init
    | Watch String
    | Play String
    | NotFoundRoute

type alias Model =
    { route : Route
    , game : Maybe Game
    , windowSize : Size
    }

initialModel : Route -> Model
initialModel route =
    { route = route
    , game = Nothing
    , windowSize = Size 0 0
    }

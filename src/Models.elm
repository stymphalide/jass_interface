module Models exposing (..)

import Window exposing (Size)
import Game.Model exposing (Game, Player)


type Route
    = Init
    | Watch Player GameId
    | Play Player GameId
    | NotFoundRoute

type alias GameId =
    String

type alias Model =
    { route : Route
    , game : Maybe Game
    , windowSize : Size
    , gameId : GameId
    , player : Player
    }


initialModel : Route -> Model
initialModel route =
    { route = route
    , game = Nothing
    , windowSize = Size 0 0
    , gameId = "3"
    , player = "pl_1"
    }

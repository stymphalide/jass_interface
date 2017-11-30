module Models exposing (..)

import Window exposing (Size)
import Game.Model exposing (Game, Player, GameId)


type Route
    = Init
    | Watch GameId
    | Play GameId
    | NotFoundRoute

type alias Model =
    { route : Route
    , game : Maybe Game
    , windowSize : Size
    , gameId : Maybe GameId
    , player : Player
    , activeGameId : Maybe GameId
    }

initialModel : Route -> Model
initialModel route =
    { route = route
    , game = Nothing
    , windowSize = Size 0 0
    , gameId = Nothing
    , player = "pl_1"
    , activeGameId = Nothing
    }
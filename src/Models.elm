module Models exposing (..)

import Window exposing (Size)
import Game.Model exposing (Game, Player, GameId)


type Route
    = Init
    | Watch GameId
    | Play
    | NotFoundRoute

type Input a
    = Changing a
    | Constant a

type alias Model =
    { route : Route
    , game : Maybe Game
    , windowSize : Size
    , player : Input Player
    , gameId : Maybe GameId
    }

initialModel : Route -> Model
initialModel route =
    { route = route
    , game = Nothing
    , windowSize = Size 0 0
    , gameId = Nothing
    , player = Changing ""
    }
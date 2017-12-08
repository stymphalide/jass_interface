module Models exposing (..)

import Window exposing (Size)
import Game.Model exposing (Game, Player, GameId, Action)

type Mode
    = Init
    | Watch GameId Player
    | Play GameId Player
    | Lobby (List Player)

type Input a
    = Changing a
    | Constant a

type alias Model =
    { mode : Mode
    , game : Maybe Game
    , games : Maybe (List GameId)
    , windowSize : Size
    , player : Input Player
    , gameId : Maybe GameId
    }

initialModel : Model
initialModel =
    { mode = Init
    , game = Nothing
    , games = Nothing
    , windowSize = Size 0 0
    , gameId = Nothing
    , player = Changing ""
    }
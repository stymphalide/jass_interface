module Models exposing (..)

import Window exposing (Size)
import Game.Model exposing (Game, Player, GameId)


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
    , windowSize : Size
    , player : Input Player
    , gameId : Maybe GameId
    }

initialModel : Model
initialModel =
    { mode = Init
    , game = Nothing
    , windowSize = Size 0 0
    , gameId = Nothing
    , player = Changing ""
    }
module Models exposing (..)
{-
    @moduledoc
    Provides the models used on a high level
    Not so much gameSpecific
-}

import Window exposing (Size)
import Game.Model exposing (Game, Player, GameId, Action)

-- This type keeps track of the virtual position of a player.
type Mode
    = Init
    | Watch GameId Player
    | Play GameId Player
    | Lobby (List Player)

-- For input fields, that are often changing but need to be validated
type Input a
    = Changing a
    | Constant a

{-
    The main type of the program.
    It consists of the virtualPosition or Mode
    The information about an active game
    A list of all played games
    The window size
    The players Name
    The gameId related to the active game

-}
type alias Model =
    { mode : Mode
    , game : Maybe Game
    , games : Maybe (List GameId)
    , windowSize : Size
    , player : Input Player
    , gameId : Maybe GameId
    }

{-
    @doc
    This returns the initial model.
    Its virtual position is init,
-}
initialModel : Model
initialModel =
    { mode = Init
    , game = Nothing
    , games = Nothing
    , windowSize = Size 0 0
    , gameId = Nothing
    , player = Changing ""
    }
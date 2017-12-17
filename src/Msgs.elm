module Msgs exposing (..)
{-
    @moduledoc
    Provides two types that are used to send message to the Update module
    the different types are:
        OnLocationChange ==> Changes virtual location of the site
        PlayerChange ==> Any update to the input string at the beginning
        InitUpdate ==> Updates received from the server consists of a list of games
        FetchGame ==> Command to send data to the server
        GameIdUpdate ==> When a Game Id is selected in the init mode
        GameUpdate ==> When a new gameString is received from the wss (as a response to fetchGame)
        LobbyUpdate ==> When a new player joins the lobby.
        SizeUpdated ==> When the window is resized.
-}

-- Gets the Window size from the browser
-- Size has width and height
import Window exposing (Size)

import Models exposing (Mode)

import Game.Model exposing (Player, GameId, GameCoord, Action)


type Msg
    = OnLocationChange Mode
    | PlayerChange InputUpdate
    | InitUpdate String
    | FetchGame (Maybe GameCoord) (Maybe Player) Action
    | GameIdUpdate GameId
    | GameUpdate String
    | LobbyUpdate String
    | SizeUpdated Size

-- Allows to store one value in one variable
-- But it can either be changing as in with every key pressed
-- Or unchanging when validated
type InputUpdate 
    = Update String
    | Approve
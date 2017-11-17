module Models exposing (..)

import Game.Model exposing (Game)


type Route
    = Init
    | Watch String
    | Play String
    | NotFoundRoute

type alias Model =
    { route : Route
    , game : Maybe Game
    }

initialModel : Route -> Model
initialModel route =
    {
        route = route
    ,   game = Nothing
    }

module Models exposing (..)

type Route
    = Init
    | Watch String
    | Play String
    | NotFoundRoute

type alias Model =
    { route : Route
    }

initialModel : Route -> Model
initialModel route =
    {
        route = route
    }

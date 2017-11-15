module Routing exposing (..)


import Navigation exposing (Location)
import UrlParser exposing (..)

import Models exposing (Route(..))

matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map Init top
        , map Play (s "play" </> string )
        , map Watch (s "watch" </> string)
        ]

parseLocation : Location -> Route
parseLocation location =
    case (parsePath matchers location) of
        Just route ->
            route
        Nothing ->
            NotFoundRoute

gamePath : String -> String
gamePath path=
    "/" ++ path ++ "/"
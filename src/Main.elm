module Main exposing (..)



import Navigation exposing (Location)


import Routing

import Models exposing (Model, initialModel)
import Msgs exposing (Msg)
import Updates exposing (update)
import View exposing (view)
import Subscriptions exposing (subscriptions)

-- INIT

init : Location -> (Model, Cmd Msg)
init location =
    let cRoute = 
        Routing.parseLocation location
    in
        (initialModel cRoute, Cmd.none)


-- MAIN
main : Program Never Model Msg
main =
    Navigation.program Msgs.OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
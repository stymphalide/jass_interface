module Main exposing (..)



import Html exposing (Html, div, text, program)
import Navigation exposing (Location)


import Routing

import Models exposing (Model, initialModel)
import Msgs exposing (Msg)
import Updates exposing (update)
import View exposing (view)


-- INIT

init : Location -> (Model, Cmd Msg)
init location =
    let cRoute = 
        Routing.parseLocation location
    in
        (initialModel cRoute, Cmd.none)



-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


-- MAIN
main : Program Never Model Msg
main =
    Navigation.program Msgs.OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
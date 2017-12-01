module Main exposing (..)
import Html exposing (program)


import Commands exposing (getWindowSize)
import Models exposing (Model, initialModel)
import Msgs exposing (Msg)
import Updates exposing (update)
import View exposing (view)
import Subscriptions exposing (subscriptions)


-- INIT

init : (Model, Cmd Msg)
init =
    (initialModel, initialSize)

initialSize : Cmd Msg
initialSize =
    getWindowSize


-- MAIN
main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
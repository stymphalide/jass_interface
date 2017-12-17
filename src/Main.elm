module Main exposing (..)

{-
    @moduledoc
    This module keeps the nuts and bolts of the program together.
    This is accomplished using the Html program.
-}

-- This is an elm library for working with html tags
import Html exposing (program)

import Commands exposing (getWindowSize)
import Models exposing (Model, initialModel)
import Msgs exposing (Msg)
import Updates exposing (update)
import View exposing (view)
import Subscriptions exposing (subscriptions)


-- INIT
-- This function returns the initial model and the window size
init : (Model, Cmd Msg)
init =
    (initialModel, initialSize)

-- Gets the size from the window.
initialSize : Cmd Msg
initialSize =
    getWindowSize


-- MAIN
{-
    @doc
    This is the core part of our program.
    It initialises the model (init)
    Renders and updates the model (view, update)
    as well as it listens to subscriptions.
-}
main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
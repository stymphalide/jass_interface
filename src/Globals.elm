module Globals exposing (..)
{-
    @moduledoc
    Global information that every module needs.
-}

import Html exposing (Html, div, text)
import Msgs exposing (Msg)

-- The url to the websocket
serverUrl : String
serverUrl =
    "ws://localhost:5000"

-- The path to the images
imgSourcePath : String
imgSourcePath =
    "../../img/"

-- An error html msg
error : Html Msg
error =
    div [] [text "An error has occurred..."]

type alias Position =
    {x : Int, y : Int}

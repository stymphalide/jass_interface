module Globals exposing (..)

import Html exposing (Html, div, text)
import Msgs exposing (Msg)

serverUrl : String
serverUrl =
    "ws://localhost:5000"

imgSourcePath : String
imgSourcePath =
    "../../img/"

error : Html Msg
error =
    div [] [text "An error has occurred..."]
module Subscriptions exposing (..)


import WebSocket exposing(..)

import Models exposing (Model)
import Msgs exposing (Msg)
import Routing exposing (serverUrl)






-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
    listen serverUrl Msgs.GameUpdate


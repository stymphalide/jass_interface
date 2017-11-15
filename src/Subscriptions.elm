module Subscriptions exposing (..)


import WebSocket

import Models exposing (Model)
import Msgs exposing (Msg)



serverUrl : String
serverUrl =
    "ws://localhost:5000"



-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
    WebSocket.listen serverUrl Msgs.GameUpdate


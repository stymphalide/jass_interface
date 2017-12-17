module Subscriptions exposing (..)
{-
    @moduldoc
    Listens to any subscriptions the program has.
    The most important one is any message from the webSocketServer.
    The other one is whenever the window resizes.
-}

-- Everything necessary for the webSocket like listen
import WebSocket exposing (..)
import Window exposing (resizes)

import Models exposing (Model, Mode(..))
import Msgs exposing (Msg)
import Globals exposing (serverUrl)






-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ windowResizes model
        , webSocketSubscripiton model
        ]


windowResizes : Model -> Sub Msg
windowResizes model =
    resizes Msgs.SizeUpdated

-- Handles inputs from the webSocketServer
-- Depending on the mode different messages are sent.
webSocketSubscripiton model =
    case model.mode of 
        Init ->
            listen serverUrl Msgs.InitUpdate
        Play gameId player ->
            listen serverUrl Msgs.GameUpdate
        Lobby player ->
            listen serverUrl Msgs.LobbyUpdate
        Watch  gameId player->
            listen serverUrl Msgs.GameUpdate

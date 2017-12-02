module Subscriptions exposing (..)


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

module Subscriptions exposing (..)


import WebSocket exposing (..)
import Window exposing (resizes)

import Models exposing (Model)
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
    case model.route of 
        Models.Init ->
            Sub.none
        Models.Play ->
            listen serverUrl Msgs.GameUpdate
        Models.Watch gameId->
            listen serverUrl Msgs.GameUpdate
        Models.NotFoundRoute ->
            Sub.none
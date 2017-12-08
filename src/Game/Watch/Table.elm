module Game.Watch.Table exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, src, width, height)

import Msgs exposing (Msg)
import Globals exposing (imgSourcePath)

import Game.Model exposing (Table, Card)

import Game.Watch.Card exposing (viewCard)

type alias Position =
    { x : Int
    , y : Int
    }
type alias Size =
    { x : Int
    , y : Int
    }


viewTable : Table -> Html Msg
viewTable table =
    div [] 
    [ ol [] 
        [ viewTableCard table.pos1 {x = 0, y = 0}
        , viewTableCard table.pos2 {x = 100, y = 0}
        , viewTableCard table.pos3 {x = 100, y = 100}
        , viewTableCard table.pos4 {x = 0, y = 100}
        ]
    , viewBackground {x = 500, y = 500}
    ]

viewBackground : Size -> Html Msg
viewBackground size =
    img [src (imgSourcePath ++ "jass_teppich_green.png"), class "absolute", height size.y, width size.x] []

viewTableCard : Maybe Card -> Position -> Html Msg
viewTableCard mCard position =
    case mCard of
        Nothing ->
            viewEmptyCard
        Just card ->
            viewCard card

viewEmptyCard : Html Msg
viewEmptyCard =
    img [src (imgSourcePath ++ "empty_card.png"), width 70] []
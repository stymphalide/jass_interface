module Game.Play.Table exposing (..)

import Html exposing (..)
import Html.Attributes exposing (src, width)

import Msgs exposing (Msg)
import Globals exposing (imgSourcePath)

import Game.Model exposing (Table, Card)

import Game.Play.Card exposing (viewCard)


viewTable : Table -> Html Msg
viewTable table =
    ol [] 
        [ viewTableCard table.pos1
        , viewTableCard table.pos2
        , viewTableCard table.pos3
        , viewTableCard table.pos4
        ]

viewTableCard : Maybe Card -> Html Msg
viewTableCard mCard =
    case mCard of
        Nothing ->
            viewEmptyCard
        Just card ->
            viewCard card

viewEmptyCard : Html Msg
viewEmptyCard =
    img [src (imgSourcePath ++ "empty_card.png"), width 70] []
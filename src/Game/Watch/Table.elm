module Game.Watch.Table exposing (..)

--import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (class, src, width, height)

import Msgs exposing (Msg)
import Globals exposing (imgSourcePath)

import Game.Model exposing (Table, Card)

import Game.Watch.Card exposing (viewCard)



viewTable : Table -> Html.Html Msg
viewTable table =
    div [] 
    [ ol [] 
        [ viewTableCard table.pos1
        , viewTableCard table.pos2
        , viewTableCard table.pos3
        , viewTableCard table.pos4
        ]
    , viewBackground 
    ]
    |> toUnstyled

viewBackground : Html Msg
viewBackground  =
    img [src (imgSourcePath ++ "jass_teppich_green.png")] []

viewTableCard : Maybe Card -> Html Msg
viewTableCard mCard =
    case mCard of
        Nothing ->
            viewEmptyCard
        Just card ->
            viewCard card |> fromUnstyled

viewEmptyCard : Html Msg
viewEmptyCard =
    img [src (imgSourcePath ++ "empty_card.png"), width 70] []
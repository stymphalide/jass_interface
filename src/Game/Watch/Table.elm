module Game.Watch.Table exposing (..)

import Window exposing (Size)

import Html
import Html.Attributes exposing (src)
import Svg exposing (..)
import Svg.Attributes exposing (..)


import Msgs exposing (Msg)
import Globals exposing (imgSourcePath)

import Game.Model exposing (Table, Card)

import Game.Watch.Card exposing (viewCard)



viewTable : Size -> Table -> Html.Html Msg
viewTable size table =
    svg 
    [ width <| toString size.width  
    , height <| toString size.height
    ]
    [ rect [ x "10", y "10", width "100", height "100", rx "15", ry "15" ] [] ]
{-
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

    -}
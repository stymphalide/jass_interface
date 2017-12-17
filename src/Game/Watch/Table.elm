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

type alias Position =
    {x : Int, y : Int}


viewTable : Size -> Table -> Html.Html Msg
viewTable size table =
    svg 
    [ width <| toString size.width  
    , height <| toString size.height
    ]
    [ viewBackground size
    , viewTableCards [table.pos1, table.pos2, table.pos3, table.pos4]
    ]

viewBackground : Size -> Svg Msg
viewBackground  size =
    image 
    [ xlinkHref (imgSourcePath ++ "jass_teppich_green.png")
    , width  <| toString size.width
    , height <| toString size.height 
    ] []

viewTableCards : Size -> List (Maybe Card) -> List (Svg msg)
viewTableCards size cards =
    let
        cardWidth = 
            size.width / 5 |> round
        cardHeight =
            cardWidth / 2.876397107 |> round
        cardSize =
           {size | width = cardWidth, height = cardHeight}
        fixedSizeTableCard =
            (viewTableCard cardSize)
        positions =
            cardPositions size
    in
          List.map2 fixedSizeTableCard positions cards
cardPositions : Size -> List Position
cardPositions size =
    []

viewTableCard : Size -> Position -> Maybe Card -> Svg msg
viewTableCard pos size mCard =
    case mCard of
        Nothing ->
            viewEmptyCard size pos
        Just card ->
            viewCard size pos card 


viewEmptyCard : Size -> Position -> Svg msg
viewEmptyCard size pos =
    image 
    [ xlinkHref (imgSourcePath ++ "empty_card.png")
    , x <| pos.x |> toString
    , y <| pos.y |> toString
    , width <| size.width |> toString
    , height <| size.height |> toString 
    ]
    []
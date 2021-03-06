module Game.Watch.Table exposing (..)
{-
    @moduledoc
    Defines how the table looks like:
        Green carpet as background
        four cards and placeholders if empty.
-}


import Window exposing (Size)

import Html
import Svg exposing (..)
import Svg.Attributes exposing (..)


import Msgs exposing (Msg)
import Globals exposing (imgSourcePath, Position)

import Game.Model exposing (Table, Card, Language)

import Game.Watch.Card exposing (viewSvgCard)

viewSvgTable : Language -> Size -> Position -> Table -> List (Svg msg)
viewSvgTable lang size pos table =
    List.concat [viewBackground size pos, viewTableCards lang size pos [table.pos1, table.pos2, table.pos3, table.pos4]]

-- Adds the green carpet
viewBackground : Size -> Position-> List (Svg msg)
viewBackground size pos =
    [image 
    [ xlinkHref (imgSourcePath ++ "jass_teppich_green.png")
    , x <| toString pos.x
    , y <| toString pos.y
    , width  <| toString size.width
    , height <| toString size.height 
    ] []]
-- Renders the cards.
viewTableCards : Language -> Size ->  Position -> List (Maybe Card) -> List (Svg msg)
viewTableCards lang size pos cards =
    let
        cardWidth = 
            (toFloat size.width) / 5 |> round
        cardHeight =
            (toFloat cardWidth) * 1.561797753 |> round
        cardSize =
           {size | width = cardWidth, height = cardHeight}
        fixedSizeTableCard =
            (viewTableCard lang cardSize)
        positions =
            cardPositions size pos
    in
        List.map2 fixedSizeTableCard positions cards
-- Helper to determine the cards position on hte field
-- The Values are the number of pixels in the original picture.
cardPositions : Size -> Position -> List Position
cardPositions size pos =
    let
        factor =
            toFloat size.width / 497
        pos1 =
            { x = 156 * factor |> round |> (+) pos.x 
            , y = 100 * factor |> round |> (+) pos.y 
            }
        pos2 =
            { x = 156 * factor |> round |> (+) pos.x 
            , y = 247 * factor |> round |> (+) pos.y 
            }
        pos3 = 
            { x = 247 * factor |> round |> (+) pos.x 
            , y = 247 * factor |> round |> (+) pos.y 
            }
        pos4 =
            { x = 247 * factor |> round |> (+) pos.x 
            , y = 100 * factor |> round |> (+) pos.y 
            }
    in
        [pos1, pos2, pos3, pos4]
-- Actually renders the cards uses the svgCard function.
viewTableCard : Language -> Size -> Position -> Maybe Card -> Svg msg
viewTableCard lang size pos mCard =
    case mCard of
        Nothing ->
            viewEmptyCard size pos
        Just card ->
            viewSvgCard lang size pos card


viewEmptyCard : Size -> Position -> Svg msg
viewEmptyCard size pos =
    image
    [ xlinkHref (imgSourcePath ++ "empty_card.png")
    , x <| toString pos.x 
    , y <| toString pos.y
    , width <| toString size.width
    , height <| toString size.height
    ]
    []
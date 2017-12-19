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

import Game.Model exposing (Table, Card)

import Game.Watch.Card exposing (viewSvgCard)

-- Solves that with a svg part
-- thent adds the pictures to it.
viewTable : Size -> Table -> Html.Html Msg
viewTable size table =
    svg 
    [ width <| toString size.width  
    , height <| toString size.height
    ]
    <|
    List.concat
    [ viewBackground size
    , viewTableCards size [table.pos1, table.pos2, table.pos3, table.pos4]
    ]
-- Adds the green carpet
viewBackground : Size -> List (Svg msg)
viewBackground size =
    [image 
    [ xlinkHref (imgSourcePath ++ "jass_teppich_green.png")
    , width  <| toString size.width
    , height <| toString size.height 
    ] []]
-- Renders the cards.
viewTableCards : Size -> List (Maybe Card) -> List (Svg msg)
viewTableCards size cards =
    let
        cardWidth = 
            (toFloat size.width) / 5 |> round
        cardHeight =
            (toFloat cardWidth) * 1.561797753 |> round
        cardSize =
           {size | width = cardWidth, height = cardHeight}
        fixedSizeTableCard =
            (viewTableCard cardSize)
        positions =
            cardPositions size
    in
        List.map2 fixedSizeTableCard positions cards
-- Helper to determine the cards position on hte field
-- The Values are the number of pixels in the original picture.
cardPositions : Size -> List Position
cardPositions size =
    let
        factor =
            toFloat size.width / 497
        pos1 =
            { x = 156 * factor |> round
            , y = 100 * factor |> round
            }
        pos2 =
            { x = 156 * factor |> round
            , y = 247 * factor |> round
            }
        pos3 = 
            { x = 247 * factor |> round
            , y = 247 * factor |> round
            }
        pos4 =
            { x = 247 * factor |> round
            , y = 100 * factor |> round
            }
    in
        [pos1, pos2, pos3, pos4]
-- Actually renders the cards uses the svgCard function.
viewTableCard : Size -> Position -> Maybe Card -> Svg msg
viewTableCard size pos mCard =
    case mCard of
        Nothing ->
            viewEmptyCard size pos
        Just card ->
            viewSvgCard size pos card


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
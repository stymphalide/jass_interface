module Game.Watch.Game exposing (..)
{-
    @moduledoc
    Handles the main parts of how to render the game.
-}


import List
import Window exposing (Size)
import Html exposing (..)
import Svg exposing (svg)
import Html.Attributes exposing (class, src)
import Svg.Attributes as SA
import Html.Events exposing (onClick)

import Msgs exposing (Msg)
import Globals exposing (imgSourcePath, Position)

import Game.Model exposing (..)
import Game.Translate exposing (colorTranslate)

import Game.Watch.Players exposing (viewSvgPlayers)
import Game.Watch.PlayerCards exposing (viewPlayerCards)
import Game.Watch.Groups exposing (viewGroup, unwrapMaybeGroups)
import Game.Watch.Table exposing (viewSvgTable)

-- One needs to actually fetch the game by pressing on the link
init :  Html Msg
init =
    div [] 
        [ a [Msgs.FetchGame Nothing Nothing NoAction |> onClick ] [text "Start Game"]
        ]

-- Nuts and bolts of rendering the game
-- left and right col are the groups
-- middle is the board and cards as well as the nav.
viewGame : Size -> Game -> Html Msg
viewGame size game =
    div [class "clearfix"]
    [ div [class "col col-3"] 
        [ (toFloat size.width / 4 |> round)
        |> viewGroup game.language (List.head game.groups) 
        ]
    , div [class "col col-6 center"]
        [ nav game.language game.activePlayer (game.round, game.turn) game.gameType
        --, ol [class "list-reset"] (viewPlayers (game.round, game.turn) (game.players, game.activePlayer, game.onTurnPlayer) )
        , viewGameBoard size game 
        , ol [class "list-reset"] (viewPlayerCards game.language game.cardsPlayer (toFloat size.width / 2 |> round) )
        ]
    , div [class "col col-3"] 
        [ (toFloat size.width / 4 |> round)
        |> viewGroup game.language (List.head (unwrapMaybeGroups (List.tail game.groups))) 
        ]
    ]

viewGameBoard : Size -> Game -> Html Msg
viewGameBoard sizeGlobal game =
    let
        size =
            sizeGameBoard sizeGlobal
    in
        svg
        [ SA.width <| toString size.width
        , SA.height <| toString size.height
        ]
        <|
        List.concat 
        [ viewSvgTable game.language (sizeTable size) (posTable size) game.table
        , viewSvgPlayers  {x = 0, y = 0} size (game.round, game.turn) (game.players, game.activePlayer, game.onTurnPlayer) 
        ]
            

sizeGameBoard : Size -> Size
sizeGameBoard sizeGlobal =
        let
        newsize =
            if sizeGlobal.width < sizeGlobal.height then
                sizeGlobal.width 
                |> toFloat 
                |> (*) 0.55
                |> round
            else
                sizeGlobal.height 
                |> toFloat 
                |> (*) 0.55
                |> round
    in
        {sizeGlobal | width = newsize, height = newsize}
posTable : Size -> Position
posTable sizeGameBoard =
    let
        posX =
            toFloat sizeGameBoard.width * 0.05 |> round
        posY =
            toFloat sizeGameBoard.height * 0.05 |> round
    in
        {x = posX, y = posY}    
-- Helper
-- Make the table square format, such that it fills ca 50 % of the screen.
sizeTable : Size -> Size
sizeTable sizeGameBoard =
    let
        newsize =
            if sizeGameBoard.width < sizeGameBoard.height then
                sizeGameBoard.width 
                |> toFloat 
                |> (*) 0.9
                |> round
            else
                sizeGameBoard.height 
                |> toFloat 
                |> (*) 0.9
                |> round
    in
        {width = newsize, height = newsize}


-- Renders the GameType from the Game record received.
viewGameType : Language -> GameType -> Html Msg
viewGameType lang gameType =
    case gameType of
        NoGameType ->
            div [] [img  [src (imgSourcePath ++ "question_mark.png")] [] ]
        Swap ->
            div [] [img [src (imgSourcePath ++ "swap_icon.png")] []]
        Up ->
            div [] [img  [src (imgSourcePath ++ "obenabe.png")] [] ]
        Down ->
            div [] [img [src (imgSourcePath ++ "undenufe.png")] [] ]
        Color color ->
            div [] [img [src (imgSourcePath ++ (colorTranslate lang color)++ "_icon.png") ] []]

-- Handles navigation (so far the players and the arrows are used.)
nav : Language -> Player -> GameCoord -> GameType -> Html Msg
nav lang  player (round, turn) gameType =
    div [] 
    [ div [class "left"] 
        [ h2 [] [text player]
        , h2 [] [text ("Round #" ++ (toString (round, turn)))]
    ]
    , div [class "right"]
        [ viewGameType lang gameType
        ]
    , prev player (round, turn)
    , next player (round, turn)
    ]

--Arrow to fetch next turn/round
next : Player -> GameCoord  -> Html Msg
next player gameCoord =
    if not (isEnd gameCoord) then
        img 
        [ src (imgSourcePath ++ "right_arrow.png")
        ,  Msgs.FetchGame (Just (nextRound gameCoord)) (Just player) NoAction     
            |> onClick
        ] []
    else 
        div [][]
-- Helper for determining whether there should be the next arrow or not.
isEnd : GameCoord -> Bool
isEnd (round, turn) =
    round == 9 && turn == 0

-- determines the coord. of the next round
nextRound : GameCoord -> GameCoord
nextRound (round, turn) =
    if turn == 4 then
        (round + 1, 0)
    else
        (round, turn + 1)

-- similar to next but for the previous.

prev : Player -> GameCoord -> Html Msg
prev player gameCoord =
    if not (isBegin gameCoord) then
        img
        [ src (imgSourcePath ++ "left_arrow.png")
        ,  Msgs.FetchGame (Just (prevRound gameCoord)) (Just player) NoAction
            |> onClick
        ][]
    else
        div [] []

isBegin : GameCoord -> Bool
isBegin (round, turn) =
    round == 0 && turn == 0

prevRound : GameCoord -> GameCoord
prevRound (round, turn) =
    if turn == 0 then
        (round - 1, 4)
    else
        (round, turn - 1)
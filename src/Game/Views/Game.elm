module Game.Views.Game exposing (..)

import List
import Html exposing (..)
import Html.Attributes exposing (src, class)
import Html.Events exposing (onClick)

import Msgs exposing (Msg)
import Globals exposing (imgSourcePath)

import Game.Model exposing (Game)
import Game.Translate exposing (colorTranslate)

import Game.Views.Players exposing (viewPlayers, viewPlayerCards)
import Game.Views.Groups exposing (viewGroup, unwrapMaybeGroups)
import Game.Views.Table exposing (viewTable)

viewGame : Game -> Html Msg
viewGame game =
    div [] 
    [ h1 [] [viewGameType game.gameType]
    , h2 [] [text game.activePlayer]
    , h2 [] [text ("Round #" ++ (toString (game.round, game.turn)))]
    , div [] [nav game.round game.turn]
    , ol [class "list-reset"] (viewPlayerCards game.cardsPlayer)
    , ol [class "list-reset"] (viewPlayers game.activePlayer game.onTurnPlayer game.players)
    , div [] 
        [ viewGroup (List.head game.groups)
        , viewGroup (List.head (unwrapMaybeGroups (List.tail game.groups)))
        ]
    , viewTable game.table
    ]

viewGameType : String -> Html Msg
viewGameType gameType =
    if (gameType == "up") then
        div [] [img  [src (imgSourcePath ++ "obenabe.png")] [] ]
    else if (gameType == "down") then
        div [] [img [src (imgSourcePath ++ "undenufe.png")] [] ]
    else
        div []
        [img [src (imgSourcePath ++ (colorTranslate gameType)++ "_icon.png") ] []]

nav : Int -> Int -> Html Msg
nav round turn =
    div [] 
    [ prev round turn 
    , next round turn
    ]

next : Int -> Int -> Html Msg
next round turn =
    if not (isEnd round turn) then
        img 
        [ src (imgSourcePath ++ "right_arrow.png")
        , (nextRound round turn)
            |> Msgs.FetchGame
            |> onClick
        ] []
    else 
        div [][]


isEnd : Int -> Int -> Bool
isEnd round turn =
    round == 8 && turn == 4

nextRound : Int -> Int -> (Int, Int)
nextRound round turn =
    if turn == 4 then
        (round + 1, 0)
    else
        (round, turn + 1)


prev : Int -> Int -> Html Msg
prev round turn =
    if not (isBegin round turn) then
        img
        [ src (imgSourcePath ++ "left_arrow.png")
        , (prevRound round turn)
            |> Msgs.FetchGame
            |> onClick
        ][]
    else
        div [] []

isBegin : Int -> Int -> Bool
isBegin round turn =
    round == 0 && turn == 0

prevRound : Int -> Int -> (Int, Int)
prevRound round turn =
    if turn == 0 then
        ( round - 1, 4)
    else
        (round, turn - 1)
module Game.Views.Game exposing (..)

import List
import Html exposing (..)
import Html.Attributes exposing (src, class)
import Html.Events exposing (onClick)

import Msgs exposing (Msg)
import Globals exposing (imgSourcePath)

import Game.Model exposing (Game, GameCoord, Player, GameId)
import Game.Translate exposing (colorTranslate)

import Game.Views.Players exposing (viewPlayers, viewPlayerCards)
import Game.Views.Groups exposing (viewGroup, unwrapMaybeGroups)
import Game.Views.Table exposing (viewTable)

viewGame : Bool -> Game -> GameId -> Html Msg
viewGame isWatch game gameId =
    div [] 
    [ h1 [] [viewGameType game.gameType]
    , h2 [] [text game.activePlayer]
    , h2 [] [text ("Round #" ++ (toString (game.round, game.turn)))]
    , div [] [nav game.activePlayer (game.round, game.turn) gameId]
    , ol [class "list-reset"] (viewPlayerCards game.cardsPlayer)
    , ol [class "list-reset"] (viewPlayers isWatch (game.round, game.turn) gameId game.activePlayer game.onTurnPlayer game.players)
    , viewTable game.table
    , div [] 
        [ viewGroup (List.head game.groups)
        , viewGroup (List.head (unwrapMaybeGroups (List.tail game.groups)))
        ]
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

nav : Player -> GameCoord -> GameId -> Html Msg
nav player gameCoord gameId =
    div [] 
    [ prev player gameCoord gameId
    , next player gameCoord gameId
    ]

next : Player -> GameCoord -> GameId -> Html Msg
next player gameCoord gameId =
    if not (isEnd gameCoord) then
        img 
        [ src (imgSourcePath ++ "right_arrow.png")
        ,  Msgs.FetchGame (nextRound gameCoord) player gameId
            |> onClick
        ] []
    else 
        div [][]


isEnd : GameCoord -> Bool
isEnd (round, turn) =
    round == 9 && turn == 0

nextRound : GameCoord -> GameCoord
nextRound (round, turn) =
    if turn == 4 then
        (round + 1, 0)
    else
        (round, turn + 1)


prev : Player -> GameCoord -> GameId-> Html Msg
prev player gameCoord gameId =
    if not (isBegin gameCoord) then
        img
        [ src (imgSourcePath ++ "left_arrow.png")
        , Msgs.FetchGame (prevRound gameCoord) player gameId
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
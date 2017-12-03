module Game.Watch.Game exposing (..)

import List
import Html exposing (..)
import Html.Attributes exposing (src, class)
import Html.Events exposing (onClick)

import Msgs exposing (Msg)
import Globals exposing (imgSourcePath)

import Game.Model exposing (..)
import Game.Translate exposing (colorTranslate)

import Game.Watch.Players exposing (viewPlayers, viewPlayerCards)
import Game.Watch.Groups exposing (viewGroup, unwrapMaybeGroups)
import Game.Watch.Table exposing (viewTable)


init :  Html Msg
init =
    div [] 
        [ a [Msgs.FetchGame Nothing Nothing NoAction |> onClick ] [text "Start Game"]
        ]


viewGame : Game -> Html Msg
viewGame game =
    div [] 
    [ h1 [] [viewGameType game.gameType]
    , h2 [] [text game.activePlayer]
    , h2 [] [text ("Round #" ++ (toString (game.round, game.turn)))]
    , div [] [nav game.activePlayer (game.round, game.turn)]
    , ol [class "list-reset"] (viewPlayerCards game.cardsPlayer)
    , ol [class "list-reset"] (viewPlayers (game.round, game.turn) game.activePlayer game.onTurnPlayer game.players)
    , viewTable game.table
    , div [] 
        [ viewGroup (List.head game.groups)
        , viewGroup (List.head (unwrapMaybeGroups (List.tail game.groups)))
        ]
    ]





viewGameType : GameType -> Html Msg
viewGameType gameType =
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
            div [] [img [src (imgSourcePath ++ (colorTranslate color)++ "_icon.png") ] []]

nav : Player -> GameCoord  -> Html Msg
nav player gameCoord =
    div [] 
    [ prev player gameCoord
    , next player gameCoord
    ]

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


isEnd : GameCoord -> Bool
isEnd (round, turn) =
    round == 9 && turn == 0

nextRound : GameCoord -> GameCoord
nextRound (round, turn) =
    if turn == 4 then
        (round + 1, 0)
    else
        (round, turn + 1)


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
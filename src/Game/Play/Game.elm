module Game.Play.Game exposing (..)

import List
import Html exposing (..)
import Html.Attributes exposing (src, class)
import Html.Events exposing (onClick)

import Msgs exposing (Msg)
import Globals exposing (imgSourcePath)

import Game.Model exposing (Game, GameCoord, GameType(..), Action(..))
import Game.Translate exposing (colorTranslate)

import Game.Play.Players exposing (viewPlayers, viewPlayerCards)
import Game.Play.Groups exposing (viewGroup, unwrapMaybeGroups)
import Game.Play.Table exposing (viewTable)

init :  Html Msg
init =
    div [] 
        [ a [  Msgs.FetchGame Nothing Nothing NoAction |> onClick] [text "Start Game"]
        ]

viewGame : Game ->  Html Msg
viewGame game =
    div [] 
    [ h1 [] [viewGameType game.gameType]
    , h2 [] [text game.activePlayer]
    , h2 [] [text ("Round #" ++ (toString (game.round, game.turn)))]
    , ol [class "list-reset"] (viewPlayerCards game.cardsPlayer)
    , ol [class "list-reset"] (viewPlayers game.activePlayer game.onTurnPlayer game.players)
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

module Game.Play.Game exposing (..)

import List
import Html exposing (..)
import Html.Attributes exposing (src, class)
import Html.Events exposing (onClick)

import Msgs exposing (Msg)
import Globals exposing (imgSourcePath)

import Game.Model exposing (Game, GameCoord, Player, GameId)
import Game.Translate exposing (colorTranslate)

import Game.Play.Players exposing (viewPlayers, viewPlayerCards)
import Game.Play.Groups exposing (viewGroup, unwrapMaybeGroups)
import Game.Play.Table exposing (viewTable)

init : Player -> GameId-> Html Msg
init player gameId  =
    div [] 
        [ a [Msgs.FetchGame (-1, -1) player gameId False |> onClick ] [text "Start Game"]
        ]

viewGame : Game -> GameId -> Html Msg
viewGame game gameId =
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

viewGameType : String -> Html Msg
viewGameType gameType =
    if (gameType == "up") then
        div [] [img  [src (imgSourcePath ++ "obenabe.png")] [] ]
    else if (gameType == "down") then
        div [] [img [src (imgSourcePath ++ "undenufe.png")] [] ]
    else
        div []
        [img [src (imgSourcePath ++ (colorTranslate gameType)++ "_icon.png") ] []]


lobby : Player -> Html Msg
lobby player = 
    div [] [ text player]
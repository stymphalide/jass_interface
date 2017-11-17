module Game.Views.Game exposing (..)

import List
import Html exposing (..)
import Html.Attributes exposing (src)

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
    , h2 [] [text ("Round #" ++ (toString (game.round +1)))]
    , ol [] (viewPlayerCards game.cardsPlayer)
    , ol [] (viewPlayers game.activePlayer game.onTurnPlayer game.players)
    , div [] 
        [ viewGroup (List.head game.groups)
        , viewGroup (List.head (unwrapMaybeGroups (List.tail game.groups)))
        ]
    , viewTable game.table
    ]

viewGameType : String -> Html Msg
viewGameType gameType =
    div []
    [ text "Trumpf: ", img [src (imgSourcePath ++ (colorTranslate gameType)++ "_icon.png") ] []]



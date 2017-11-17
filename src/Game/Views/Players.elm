module Game.Views.Players exposing (..)

import List
import Html exposing (..)
import Html.Attributes exposing (src)

import Msgs exposing (Msg)
import Globals exposing (imgSourcePath)

import Game.Model exposing (Card, Player)

import Game.Views.Card exposing (viewCard)


viewPlayers: Player -> Player -> List Player -> List (Html Msg)
viewPlayers  activePlayer onTurnPlayer players=
    List.map (viewPlayer activePlayer onTurnPlayer) players


viewPlayer : Player -> Player -> Player -> Html Msg
viewPlayer  activePlayer onTurnPlayer player =
    if player == activePlayer then
        if player == onTurnPlayer then 
            li []
            [ div [] [text player]
            , img [src (imgSourcePath ++ "playerActiveOnTurn_icon.png")] []
            ]
        else
            li []
            [ div [] [text player]
            , img [src (imgSourcePath ++ "playerActive_icon.png")] []
            ]
    else 
        if player == onTurnPlayer then 
            li []
            [ div [] [text player]
            , img [src (imgSourcePath ++ "playerOnTurn_icon.png")] []
            ]
        else 
            li []
            [ div [] [text player]
            , img [src (imgSourcePath ++ "player_icon.png")] []
            ]


viewPlayerCards : Maybe (List Card) -> List (Html Msg)
viewPlayerCards cards =
    case cards of 
        Nothing ->
            [div [] [text "No Cards received"]]
        Just cards ->
            List.map viewPlayerCard cards

viewPlayerCard : Card -> Html Msg
viewPlayerCard card =
    li [] 
    [
     viewCard card
    ]
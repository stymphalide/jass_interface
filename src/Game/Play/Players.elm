module Game.Play.Players exposing (..)

import List
import Html exposing (..)
import Html.Attributes exposing (src, class, width)
import Html.Events exposing (onClick)

import Msgs exposing (Msg)
import Globals exposing (imgSourcePath)

import Game.Model exposing (Card, Player, GameCoord, GameId)

import Game.Play.Card exposing (viewCard, viewOnTurnCard)


viewPlayers : Player -> Player -> List Player -> List (Html Msg)
viewPlayers activePlayer onTurnPlayer players=
    List.map (viewPlayer activePlayer onTurnPlayer) players


viewPlayer : Player -> Player -> Player -> Html Msg
viewPlayer activePlayer onTurnPlayer player =
    if player == activePlayer then
        if player == onTurnPlayer then 
            li [class "inline-block mr1"]
            [ div [class "col-9"] [text player]
            , getImage "playerActiveOnTurn"
            ]
        else
            li [class "inline-block mr1"]
            [ div [class "col-9"] [text player]
            , getImage "playerActive"
            ]
    else 
        if player == onTurnPlayer then 
            li [class "inline-block mr1"]
            [ div [class "col-9"] [text player]
            , getImage "playerOnTurn"
            ]
        else 
            li [class "inline-block mr1"]
            [ div [class "col-9"] [text player]
            , getImage "player"
            ]

getImage : String -> Html Msg
getImage icon =
    img 
        [ src (imgSourcePath ++ icon ++"_icon.png")
        , width 50
        ] []

viewPlayerCards : Maybe (List Card) -> List (Html Msg)
viewPlayerCards mCards =
    case mCards of 
        Nothing ->
            [div [] [text "No Cards received"]]
        Just cards ->
            List.map viewPlayerCard cards

viewPlayerCard : Card -> Html Msg
viewPlayerCard card =
    li [class "inline-block"] 
    [ div [class "sm-col sm-col-9"] 
        [viewCard card]
     
    ]

viewOnTurnPlayerCards : Maybe (List Card) -> List (Html Msg)
viewOnTurnPlayerCards mCards =
    case mCards of 
        Nothing ->
            [div [] [text "No Cards received"]]
        Just cards ->
            List.map viewOnTurnPlayerCard cards

viewOnTurnPlayerCard : Card -> Html Msg
viewOnTurnPlayerCard card =
    li [class "inline-block"] 
    [ div [class "sm-col sm-col-9"] 
        [viewOnTurnCard card]
    ]
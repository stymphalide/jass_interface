module Game.Views.Players exposing (..)

import List
import Html exposing (..)
import Html.Attributes exposing (src, class, width)
import Html.Events exposing (onClick)

import Msgs exposing (Msg)
import Globals exposing (imgSourcePath)

import Game.Model exposing (Card, Player, GameCoord)

import Game.Views.Card exposing (viewCard)


viewPlayers:Bool -> GameCoord-> Player -> Player -> List Player -> List (Html Msg)
viewPlayers isWatch gameCoord activePlayer onTurnPlayer players=
    List.map (viewPlayer isWatch gameCoord activePlayer onTurnPlayer) players


viewPlayer : Bool -> GameCoord -> Player -> Player -> Player -> Html Msg
viewPlayer isWatch gameCoord activePlayer onTurnPlayer player =
    if player == activePlayer then
        if player == onTurnPlayer then 
            li [class "inline-block mr1"]
            [ div [class "col-9"] [text player]
            , getImage isWatch gameCoord player "playerActiveOnTurn"
            ]
        else
            li [class "inline-block mr1"]
            [ div [class "col-9"] [text player]
            , getImage isWatch gameCoord player "playerActive"
            ]
    else 
        if player == onTurnPlayer then 
            li [class "inline-block mr1"]
            [ div [class "col-9"] [text player]
            , getImage isWatch gameCoord player "playerOnTurn"
            ]
        else 
            li [class "inline-block mr1"]
            [ div [class "col-9"] [text player]
            , getImage isWatch gameCoord player "player"
            ]

getImage : Bool -> GameCoord -> Player -> String -> Html Msg
getImage isWatch gameCoord player icon =
    img 
        [ src (imgSourcePath ++ icon ++"_icon.png")
        , width 50
        , changePlayer gameCoord player isWatch
        ] []

changePlayer : GameCoord -> Player -> Bool -> Attribute Msg
changePlayer gameCoord player isWatch =
    if isWatch then 
        onClick (Msgs.FetchGame gameCoord player)
    else
        noAction

noAction : Attribute msg
noAction = 
    Html.Attributes.attribute "none" ""

viewPlayerCards : Maybe (List Card) -> List (Html Msg)
viewPlayerCards cards =
    case cards of 
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
module Game.Play.Players exposing (..)

import List
import Html exposing (..)
import Html.Attributes exposing (src, class, width)
import Html.Events exposing (onClick)

import Msgs exposing (Msg)
import Globals exposing (imgSourcePath)

import Game.Model exposing (Card, Player, GameCoord, GameId)

import Game.Play.Card exposing (viewCard)


viewPlayers: Bool -> GameCoord -> GameId -> Player -> Player -> List Player -> List (Html Msg)
viewPlayers isWatch gameCoord gameId activePlayer onTurnPlayer players=
    List.map (viewPlayer isWatch gameCoord gameId activePlayer onTurnPlayer) players


viewPlayer : Bool -> GameCoord -> GameId-> Player -> Player -> Player -> Html Msg
viewPlayer isWatch gameCoord gameId activePlayer onTurnPlayer player =
    if player == activePlayer then
        if player == onTurnPlayer then 
            li [class "inline-block mr1"]
            [ div [class "col-9"] [text player]
            , getImage isWatch gameCoord player gameId "playerActiveOnTurn"
            ]
        else
            li [class "inline-block mr1"]
            [ div [class "col-9"] [text player]
            , getImage isWatch gameCoord player gameId "playerActive"
            ]
    else 
        if player == onTurnPlayer then 
            li [class "inline-block mr1"]
            [ div [class "col-9"] [text player]
            , getImage isWatch gameCoord player gameId "playerOnTurn"
            ]
        else 
            li [class "inline-block mr1"]
            [ div [class "col-9"] [text player]
            , getImage isWatch gameCoord player gameId "player"
            ]

getImage : Bool -> GameCoord -> Player -> GameId -> String -> Html Msg
getImage isWatch gameCoord player gameId icon =
    img 
        [ src (imgSourcePath ++ icon ++"_icon.png")
        , width 50
        , changePlayer gameCoord player isWatch gameId
        ] []

changePlayer : GameCoord -> Player -> Bool -> GameId -> Attribute Msg
changePlayer gameCoord player isWatch gameId =
    if isWatch then 
        onClick (Msgs.FetchGame gameCoord player gameId)
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
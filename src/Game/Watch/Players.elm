module Game.Watch.Players exposing (..)

import List
import Html exposing (..)
import Html.Attributes exposing (src, class, width)
import Html.Events exposing (onClick)

import Msgs exposing (Msg)
import Globals exposing (imgSourcePath)

import Game.Model exposing (Card, Player, GameCoord, GameId)

import Game.Watch.Card exposing (viewCard)


viewPlayers: GameCoord -> GameId -> Player -> Player -> List Player -> List (Html Msg)
viewPlayers gameCoord gameId activePlayer onTurnPlayer players=
    List.map (viewPlayer gameCoord gameId activePlayer onTurnPlayer) players


viewPlayer : GameCoord -> GameId-> Player -> Player -> Player -> Html Msg
viewPlayer gameCoord gameId activePlayer onTurnPlayer player =
    if player == activePlayer then
        if player == onTurnPlayer then 
            li [class "inline-block mr1"]
            [ div [class "col-9"] [text player]
            , getImage gameCoord player gameId "playerActiveOnTurn"
            ]
        else
            li [class "inline-block mr1"]
            [ div [class "col-9"] [text player]
            , getImage gameCoord player gameId "playerActive"
            ]
    else 
        if player == onTurnPlayer then 
            li [class "inline-block mr1"]
            [ div [class "col-9"] [text player]
            , getImage gameCoord player gameId "playerOnTurn"
            ]
        else 
            li [class "inline-block mr1"]
            [ div [class "col-9"] [text player]
            , getImage gameCoord player gameId "player"
            ]

getImage : GameCoord -> Player -> GameId -> String -> Html Msg
getImage gameCoord player gameId icon =
    img 
        [ src (imgSourcePath ++ icon ++"_icon.png")
        , width 50
        , changePlayer gameCoord player gameId
        ] []

changePlayer : GameCoord -> Player -> GameId -> Attribute Msg
changePlayer gameCoord player gameId =
    Msgs.FetchGame gameCoord player gameId True |> onClick

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
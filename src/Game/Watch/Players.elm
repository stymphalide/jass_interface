module Game.Watch.Players exposing (..)

import List
import Html exposing (..)
import Html.Attributes exposing (src, class, width)
import Html.Events exposing (onClick)

import Msgs exposing (Msg)
import Globals exposing (imgSourcePath)

import Game.Model exposing (Card, Player, GameCoord, Action(..))

import Game.Watch.Card exposing (viewCard)


viewPlayers: GameCoord -> Player -> Player -> List Player -> List (Html Msg)
viewPlayers gameCoord activePlayer onTurnPlayer players =
    List.map (viewPlayer gameCoord activePlayer onTurnPlayer) players


viewPlayer : GameCoord -> Player -> Player -> Player -> Html Msg
viewPlayer gameCoord activePlayer onTurnPlayer player =
    if player == activePlayer then
        if player == onTurnPlayer then 
            li [class "inline-block mr1"]
            [ div [class "col-9"] [text player]
            , getImage gameCoord player "playerActiveOnTurn"
            ]
        else
            li [class "inline-block mr1"]
            [ div [class "col-9"] [text player]
            , getImage gameCoord player "playerActive"
            ]
    else 
        if player == onTurnPlayer then 
            li [class "inline-block mr1"]
            [ div [class "col-9"] [text player]
            , getImage gameCoord player "playerOnTurn"
            ]
        else 
            li [class "inline-block mr1"]
            [ div [class "col-9"] [text player]
            , getImage gameCoord player "player"
            ]

getImage : GameCoord -> Player ->  String -> Html Msg
getImage gameCoord player icon =
    img 
        [ src (imgSourcePath ++ icon ++"_icon.png")
        , width 50
        , changePlayer gameCoord player
        ] []

changePlayer :  GameCoord -> Player -> Attribute Msg
changePlayer gameCoord player  =
    Msgs.FetchGame (Just gameCoord) (Just player) NoAction
    |> onClick

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
module Game.Watch.Players exposing (..)

import List
import Html exposing (..)
import Html.Attributes exposing (src, class, width)
import Html.Events exposing (onClick)

import Msgs exposing (Msg)
import Globals exposing (imgSourcePath)

import Game.Model exposing (..)

import Game.Watch.Card exposing (viewCard)

viewSvgPlayers : Position -> Size -> GameCoord -> PlayerInput -> List (Svg msg)
viewSvgPlayers pos size gameCoord (players, activePlayer, onTurnPlayer) =

playerPositions : Position -> Size -> List Position
playerPositions position size =
    [] 



viewPlayers: GameCoord -> PlayerInput -> List (Html Msg)
viewPlayers gameCoord (players, activePlayer, onTurnPlayer) =
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

viewPlayerCards : Maybe (List Card) -> Int -> List (Html Msg)
viewPlayerCards mCards width =
    case mCards of
        Nothing ->
            [div [] [text "No Cards received"]]
        Just cards ->
            let
                cardWidth =
                    (toFloat width) / 10
                    |> round
            in
                List.map (viewPlayerCard cardWidth) cards

viewPlayerCard : Int -> Card -> Html Msg
viewPlayerCard width card =
    li [class "inline-block"] 
    [ div [] 
        [viewCard width card]
     
    ]
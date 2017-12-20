module Game.Watch.Players exposing (..)

import List
import Html exposing (..)
import Svg exposing (..)
import Svg.Attributes as SA
import Svg.Events as SE
import Html.Attributes as HA
import Html.Events as HE

import Msgs exposing (Msg)
import Globals exposing (imgSourcePath, Position, Size)

import Game.Model exposing (..)

import Game.Watch.Card exposing (viewCard)

viewSvgPlayers : Position -> Size -> GameCoord -> PlayerInput -> List (Svg Msg)
viewSvgPlayers pos size gameCoord (players, activePlayer, onTurnPlayer) =
    let
        imgSrcs =
            List.map (getImageLink activePlayer onTurnPlayer) players
        gameCoords =
            List.map (changePlayer gameCoord) players 
        positions =
            playerPositions pos size
        pSize =
            playerSize size
    in
        List.map3 (viewSvgPlayer pSize) positions gameCoords imgSrcs

viewSvgPlayer : Size -> Position ->  Msg -> String -> Svg Msg
viewSvgPlayer size pos gameCoord imgSrc =
    image 
    [ SA.xlinkHref imgSrc
    , SA.x <| toString pos.x
    , SA.y <| toString pos.y
    , SA.width  <| toString size.width
    , SA.height <| toString size.height 
    , SE.onClick gameCoord
    ] []

playerSize : Size -> Size
playerSize wholeSize = -- The size should depend on the width.
    let
        size =
            toFloat wholeSize.width * 0.1 |> round
    in
        {height = size, width = size}
playerPositions : Position -> Size -> List Position
playerPositions pos size =
    let
        pSize =
            playerSize size 
        pos1 =
            pos
        pos2 = 
            {pos | y = pos.y + size.height - pSize.height}

        pos3 = 
            {pos | y = pos.y + size.height - pSize.height, x = pos.x + size.width - pSize.width}
        pos4 =
            {pos | x = pos.x + size.width - pSize.width}
    in
      [pos1, pos2, pos3, pos4] 



viewPlayers: GameCoord -> PlayerInput -> List (Html Msg)
viewPlayers gameCoord (players, activePlayer, onTurnPlayer) =
    List.map (viewPlayer gameCoord activePlayer onTurnPlayer) players

viewPlayer : GameCoord -> Player -> Player -> Player -> Html Msg
viewPlayer gameCoord activePlayer onTurnPlayer player =
    li [HA.class "inline-block mr1"]
            [ div [HA.class "col-9"] [Html.text player]
            , img 
                [ HA.src <|  getImageLink activePlayer onTurnPlayer player
                , HA.width 50
                , HE.onClick <| changePlayer gameCoord player
                ] []
            ]

getImageLink : Player -> Player -> Player -> String
getImageLink activePlayer onTurnPlayer player =
    if player == activePlayer then
        if activePlayer == onTurnPlayer then
            imgSourcePath ++ "playerActiveOnTurn_icon.png"
        else
            imgSourcePath ++ "activePlayer_icon.png"
    else
        if player == onTurnPlayer then
            imgSourcePath ++ "onTurnPlayer_icon.png"
        else
            imgSourcePath ++ "player_icon.png"
changePlayer :  GameCoord -> Player -> Msg
changePlayer gameCoord player  =
    Msgs.FetchGame (Just gameCoord) (Just player) NoAction


viewPlayerCards : Maybe (List Card) -> Int -> List (Html Msg)
viewPlayerCards mCards width =
    case mCards of
        Nothing ->
            [div [] [Html.text "No Cards received"]]
        Just cards ->
            let
                cardWidth =
                    (toFloat width) / 10
                    |> round
            in
                List.map (viewPlayerCard cardWidth) cards

viewPlayerCard : Int -> Card -> Html Msg
viewPlayerCard width card =
    li [HA.class "inline-block"] 
    [ div [] 
        [viewCard width card]
     
    ]
module Game.Watch.Players exposing (..)

import List

import Svg exposing (..)
import Svg.Attributes exposing (..)
import Svg.Events exposing (onClick)

import Msgs exposing (Msg)
import Globals exposing (imgSourcePath, Position, Size)

import Game.Model exposing (..)


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
    [ xlinkHref imgSrc
    , x <| toString pos.x
    , y <| toString pos.y
    , width  <| toString size.width
    , height <| toString size.height 
    , onClick gameCoord
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


getImageLink : Player -> Player -> Player -> String
getImageLink activePlayer onTurnPlayer player =
    if player == activePlayer then
        if activePlayer == onTurnPlayer then
            imgSourcePath ++ "playerActiveOnTurn_icon.png"
        else
            imgSourcePath ++ "playerActive_icon.png"
    else
        if player == onTurnPlayer then
            imgSourcePath ++ "playerOnTurn_icon.png"
        else
            imgSourcePath ++ "player_icon.png"

changePlayer :  GameCoord -> Player -> Msg
changePlayer gameCoord player  =
    Msgs.FetchGame (Just gameCoord) (Just player) NoAction


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

viewSvgPlayer : Size -> Position ->  GameCoord -> String -> Svg msg
viewSvgPlayer size pos gameCoord imgSrc =
    image 
    [ xlinkHref imgSrc
    , x <| toString pos.x
    , y <| toString pos.y
    , width  <| toString size.width
    , height <| toString size.height 
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
    li [class "inline-block mr1"]
            [ div [class "col-9"] [text player]
            , img 
                [ src <|  getImageLink activePlayer onTurnPlayer player
                , width 50
                , changePlayer gameCoord player
                ] []
            ]

getImageLink : Player -> Player -> Player -> String
getImageLink activePlayer onTurnPlayer player =
    case player of
        onTurnPlayer && activePlayer ->
            imgSourcePath ++ "playerActiveOnTurn_icon.png"
        activePlayer ->
            imgSourcePath ++ "activePlayer_icon.png"
        onTurnPlayer ->
            imgSourcePath ++ "onTurnPlayer_icon.png"
        _ ->
            imgSourcePath ++ "player_icon.png"
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
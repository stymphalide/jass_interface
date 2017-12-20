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
playerPositions pos size =
    let
        pos1 =
            pos
        pos2 = 
            {pos | y = pos.y + size.height}

        pos3 = 
            {pos | y = pos.y + size.height, x = pos.x + size.width}
        pos4 =
            {pos | x = pos.x + size.width}
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
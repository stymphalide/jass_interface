module Game.View exposing (..)

-- elm Libraries
import Html exposing (..)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)

import List 
-- Client Model
import Msgs exposing (Msg)
-- Game specific
import Game.Model exposing(..)
import Game.Card exposing (colorTranslate, numberTranslate)

imgSourcePath : String
imgSourcePath =
    "../../img/"

view : Maybe Game  -> Html Msg
view game =
    div []  [page game]

page : Maybe Game -> Html Msg
page game =
    case game of
        Nothing ->
            init 
        Just g ->
            viewGame g
init :  Html Msg
init =
    div [] 
        [ a [onClick Msgs.Send ] [text "Start Game"]
        ]
viewGame : Game -> Html Msg
viewGame game =
    div [] 
    [ h1 [] [viewGameType game.gameType]
    , h2 [] [text game.activePlayer]
    , h2 [] [text ("Round #" ++ (toString (game.round +1)))]
    , div [] (viewPlayerCards game.cardsPlayer)
    , div [] (viewPlayers game.activePlayer game.onTurnPlayer game.players)
    ]
viewGameType : String -> Html Msg
viewGameType gameType =
    div []
    [ text "Trumpf: ", img [src (imgSourcePath ++ (colorTranslate gameType)++ "_icon.png") ] []]

viewPlayerCards : Maybe (List Card) -> List (Html Msg)
viewPlayerCards cards =
    case cards of 
        Nothing ->
            [div [] [text "No Cards received"]]
        Just cards ->
            List.map viewPlayerCard cards

viewPlayerCard : Card -> Html Msg
viewPlayerCard card =
    img [src (getImagePath card.color card.number)] []
    --div [] [text (getImagePath card.color card.number)]

getImagePath : Color -> Number -> String
getImagePath color number =
    imgSourcePath++ (colorTranslate color) ++"_"++(numberTranslate number) ++".png"


viewPlayers: Player -> Player -> List Player -> List (Html Msg)
viewPlayers  activePlayer onTurnPlayer players=
    List.map (viewPlayer activePlayer onTurnPlayer) players


viewPlayer : Player -> Player -> Player -> Html Msg
viewPlayer  activePlayer onTurnPlayer player =
    if player == activePlayer then
        if player == onTurnPlayer then 
            div []
            [ div [] [text player]
            , img [src (imgSourcePath ++ "playerActiveOnTurn_icon.png")] []
            ]
        else
            div []
            [ div [] [text player]
            , img [src (imgSourcePath ++ "playerActive_icon.png")] []
            ]
    else 
        if player == onTurnPlayer then 
            div []
            [ div [] [text player]
            , img [src (imgSourcePath ++ "playerOnTurn_icon.png")] []
            ]
        else 
            div []
            [ div [] [text player]
            , img [src (imgSourcePath ++ "player_icon.png")] []
            ]
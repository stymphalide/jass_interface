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
    [ h1 [] [text game.gameType]
    , h2 [] [text game.activePlayer]
    , div [] (viewPlayerCards game.cardsPlayer)
    ]


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
    "../../img/"++ (colorTranslate color) ++"_"++(numberTranslate number) ++".png"
module Game.Play.Card exposing (..)

import Html exposing (..)
import Html.Attributes exposing (src, width)
import Html.Events exposing (onClick)

import Msgs exposing (Msg)
import Globals exposing (imgSourcePath)

import Game.Model exposing (Card, Number, Color, Action(..))
import Game.Translate exposing (colorTranslate, numberTranslate)



viewCard : Card -> Html Msg
viewCard card  =
    img [src (getImagePath card.color card.number), width 100] []

viewOnTurnCard : Card -> Html Msg
viewOnTurnCard card =
    img [Msgs.FetchGame Nothing Nothing (PlayCard card) |> onClick,  src (getImagePath card.color card.number), width 100] []


getImagePath : Color -> Number -> String
getImagePath color number =
    imgSourcePath++ (colorTranslate color) ++"_"++(numberTranslate number) ++".png"


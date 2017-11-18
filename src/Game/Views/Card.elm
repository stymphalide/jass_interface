module Game.Views.Card exposing (..)

import Html exposing (..)
import Html.Attributes exposing (src, width)

import Msgs exposing (Msg)
import Globals exposing (imgSourcePath)

import Game.Model exposing (Card, Number, Color)
import Game.Translate exposing (colorTranslate, numberTranslate)



viewCard : Card -> Html Msg
viewCard card  =
    img [src (getImagePath card.color card.number), width 100] []



getImagePath : Color -> Number -> String
getImagePath color number =
    imgSourcePath++ (colorTranslate color) ++"_"++(numberTranslate number) ++".png"


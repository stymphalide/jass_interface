module Game.Watch.Card exposing (..)
{-
    @moduldoc
    Specifies how to render a card.
-}

import Window exposing (Size)

import Html
import Html.Attributes exposing (src)
import Svg exposing (image)
import Svg.Attributes exposing (..)

import Msgs exposing (Msg)
import Globals exposing (imgSourcePath, Position)

import Game.Model exposing (Card, Number, Color)
import Game.Translate exposing (colorTranslate, numberTranslate)

-- Renders images as svg at certain position and size
viewSvgCard : Size -> Position -> Card -> Svg.Svg msg
viewSvgCard size pos card  =
    image
    [ xlinkHref (getImagePath card.color card.number)
    , x <| toString pos.x 
    , y <| toString pos.y
    , Svg.Attributes.width <| toString size.width
    , Svg.Attributes.height <| toString size.height
    ]
    []
-- Renders card as html with certain width.
viewCard : Int -> Card -> Html.Html Msg
viewCard width card  =
    Html.img [src (getImagePath card.color card.number), Html.Attributes.width width ] []


getImagePath : Color -> Number -> String
getImagePath color number =
    imgSourcePath++ (colorTranslate color) ++"_"++(numberTranslate number) ++".png"


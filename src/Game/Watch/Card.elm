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

import Game.Model exposing (Card, Number, Color, Language(..))
import Game.Translate exposing (colorTranslate, numberTranslate)
-- Renders images as svg at certain position and size
viewSvgCard : Language -> Size -> Position -> Card -> Svg.Svg msg
viewSvgCard lang size pos card  =
    image
    [ xlinkHref (getImagePath lang card.color card.number)
    , x <| toString pos.x 
    , y <| toString pos.y
    , Svg.Attributes.width <| toString size.width
    , Svg.Attributes.height <| toString size.height
    ]
    []
-- Renders card as html with certain width.
viewCard : Language -> Int -> Card -> Html.Html Msg
viewCard lang width card  =
    Html.img [src (getImagePath lang card.color card.number), Html.Attributes.width width ] []


getImagePath : Language -> Color -> Number -> String
getImagePath lang color number =
    imgSourcePath++ (colorTranslate lang color) ++"_"++(numberTranslate lang number) ++".png"


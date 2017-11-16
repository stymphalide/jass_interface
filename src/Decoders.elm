module Decoders exposing (..)

import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)

import Msgs exposing (Msg)
import Models exposing (Model)

import Game.Model exposing (..)




gameDecoder : Decode.Decoder Game
gameDecoder =
    decode Game
    |> required "type" Decode.string
    |> required "round" Decode.int
--    |> required "players" Decode.list playerDecoder
--    |> required "activePlayer" Decode.string
--    |> required "cardsPlayer" Decode.list cardDecoder 
 
{-
--cardDecoder : Decode.Decoder Card

    

--playerDecoder

groupDecoder

tableDecoder


type alias Game =
    { gameType : String
    , round : Int
    , players : List Player
    , group : List Group
    , activePlayer : Player
    , cardsPlayer : Maybe ( List Card ) 
    , table : Table
    }
type alias Card =
    { color : String
    , number : String 
    }

type alias Player =
    String

type alias Group =
    { points : Int
    , players : List Player
    , wonCards : Maybe (List List Card)
    }

type alias Table =
    { pos1 : Maybe Card 
    , pos2 : Maybe Card
    , pos3 : Maybe Card
    , pos4 : Maybe Card 
    }
-}
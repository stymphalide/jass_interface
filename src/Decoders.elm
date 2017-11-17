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
    |> required "turn" Decode.int
    |> required "players" (Decode.list playerDecoder)
    |> required "groups" (Decode.list groupDecoder)
    |> required "activePlayer" playerDecoder
    |> required "onTurnPlayer" playerDecoder
    |> required "cardsPlayer" (Decode.maybe(Decode.list cardDecoder) )
    |> required "cardsTable" tableDecoder


cardDecoder : Decode.Decoder Card
cardDecoder =
    decode Card
    |> required "color" Decode.string
    |> required "number" Decode.string
    

playerDecoder : Decode.Decoder Player
playerDecoder =
    Decode.string

tableDecoder : Decode.Decoder Table
tableDecoder =
    decode Table
    |> required "pos1" (Decode.maybe cardDecoder)
    |> required "pos2" (Decode.maybe cardDecoder)
    |> required "pos3" (Decode.maybe cardDecoder)
    |> required "pos4" (Decode.maybe cardDecoder)

groupDecoder : Decode.Decoder Group
groupDecoder = 
    decode Group
    |> required "points" Decode.int
    |> required "players" (Decode.list playerDecoder)
    |> required "wonCards" historyDecoder

type alias History =
    Maybe (List (List Card))

historyDecoder : Decode.Decoder History
historyDecoder =
    Decode.maybe (Decode.list (Decode.list cardDecoder))

{-


type alias Group =
    { points : Int
    , players : List Player
    , wonCards : Maybe (List List Card)
    }

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


type alias Table =
    { pos1 : Maybe Card 
    , pos2 : Maybe Card
    , pos3 : Maybe Card
    , pos4 : Maybe Card 
    }
-}
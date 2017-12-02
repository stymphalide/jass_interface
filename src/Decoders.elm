module Decoders exposing (..)

import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)

import Msgs exposing (Msg)
import Models exposing (Model)

import Game.Model exposing (..)

gameIdsDecoder : Decode.Decoder (List GameId)
gameIdsDecoder =
    Decode.list Decode.string

lobbyDecoder : Decode.Decoder Lobby
lobbyDecoder =
    Decode.oneOf [gameIdDecoder, playersDecoder]

gameIdDecoder : Decode.Decoder Lobby
gameIdDecoder =
    decode GameInfo 
    |> required "gameId" Decode.string

playersDecoder : Decode.Decoder Lobby
playersDecoder =
    Decode.map Players (Decode.list playerDecoder)

gameDecoder : Decode.Decoder Game
gameDecoder =
    decode Game
    |> required "gameType" Decode.string
    |> required "round" Decode.int
    |> required "turn" Decode.int
    |> required "players" (Decode.list playerDecoder)
    |> required "groups" (Decode.list groupDecoder)
    |> required "activePlayer" playerDecoder
    |> required "onTurnPlayer" playerDecoder
    |> required "cardsPlayer" (Decode.maybe(Decode.list cardDecoder) )
    |> required "table" tableDecoder


playerDecoder : Decode.Decoder Player
playerDecoder =
    Decode.string
    
cardDecoder : Decode.Decoder Card
cardDecoder =
    decode Card
    |> required "color" Decode.string
    |> required "number" Decode.string
    


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

historyDecoder : Decode.Decoder History
historyDecoder =
    Decode.maybe (Decode.list (Decode.list cardDecoder))

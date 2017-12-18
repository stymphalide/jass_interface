module Decoders exposing (..)
{-
    @moduledoc
    Decodes Data from the server.
-}

-- Low Level Decoders from native elm
import Json.Decode as Decode
-- High level decoders by NoRedInk.
import Json.Decode.Pipeline exposing (decode, required)

import Msgs exposing (Msg)
import Models exposing (Model)

import Game.Model exposing (..)

-- Decodes an array of strings into a list of strings
gameIdsDecoder : Decode.Decoder (List GameId)
gameIdsDecoder =
    Decode.list Decode.string

-- Decodes the lobby (necessary is a gameId or players)
lobbyDecoder : Decode.Decoder Lobby
lobbyDecoder =
    Decode.oneOf [gameIdDecoder, playersDecoder]
--Helper for the lobbyDecoder if the lobby is full and the game starts this is received
gameIdDecoder : Decode.Decoder Lobby
gameIdDecoder =
    decode GameInfo 
    |> required "gameId" Decode.string
-- Helper for lobbyDecoder if the lobby is not full, this is received
playersDecoder : Decode.Decoder Lobby
playersDecoder =
    Decode.map Players (Decode.list playerDecoder)

-- Decodes an object into a Game type specified in the Game.Models module
gameDecoder : Decode.Decoder Game
gameDecoder =
    decode Game
    |> required "gameType" gameTypeDecoder
    |> required "round" Decode.int
    |> required "turn" Decode.int
    |> required "players" (Decode.list playerDecoder)
    |> required "groups" (Decode.list groupDecoder)
    |> required "activePlayer" playerDecoder
    |> required "onTurnPlayer" playerDecoder
    |> required "cardsPlayer" (Decode.maybe(Decode.list cardDecoder) )
    |> required "table" tableDecoder

-- Decodes into a gameType specified in the Game.Model module.
gameTypeDecoder : Decode.Decoder GameType
gameTypeDecoder =
    Decode.maybe(Decode.string)
        |> Decode.andThen (\mStr ->
            case mStr of
                Nothing ->
                    Decode.succeed NoGameType
                Just str ->
                    case str of                     
                        "swap" ->
                            Decode.succeed Swap
                        "hearts" ->
                            Decode.succeed (Color "hearts")
                        "diamonds" ->
                            Decode.succeed (Color "diamonds")
                        "spades" ->
                            Decode.succeed (Color "spades")
                        "clubs" ->
                            Decode.succeed (Color "clubs" )
                        "up" ->
                            Decode.succeed Up
                        "down" ->
                            Decode.succeed Down
                        somethingElse ->
                            Decode.fail <| "Unknown theme: " ++ somethingElse
        )
-- Decodes into a player which is bascally a string
playerDecoder : Decode.Decoder Player
playerDecoder =
    Decode.string

-- Decodes into a card as specified in the Game.Models module.
cardDecoder : Decode.Decoder Card
cardDecoder =
    decode Card
    |> required "color" Decode.string
    |> required "number" Decode.string
    

-- Decodes into a table as specified in the Game.Models module.
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

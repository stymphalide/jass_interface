module Game.Play.Game exposing (..)

import List
import Html exposing (..)
import Html.Attributes exposing (src, class)
import Html.Events exposing (onClick)

import Msgs exposing (Msg)
import Globals exposing (imgSourcePath)

import Game.Model exposing (Game, GameCoord, GameType(..), Action(..), Language(..))
import Game.Translate exposing (colorTranslate)

import Game.Play.Players exposing (viewPlayers, viewPlayerCards, viewOnTurnPlayerCards)
import Game.Play.Groups exposing (viewGroup, unwrapMaybeGroups)
import Game.Play.Table exposing (viewTable)

init :  Html Msg
init =
    div [] 
        [ a [  Msgs.FetchGame Nothing Nothing NoAction |> onClick] [text "Start Game"]
        ]


viewGame : Game -> Html Msg
viewGame game =
    if game.activePlayer == game.onTurnPlayer then 
        viewOnTurnGame game
    else
        viewGameState game

viewOnTurnGame : Game -> Html Msg
viewOnTurnGame game =
    case game.gameType of
        NoGameType ->
            viewChooseGameType False
        Swap ->
            viewChooseGameType True
        any ->
            viewOnTurnGameState game

viewChooseGameType : Bool -> Html Msg
viewChooseGameType isSwap =
    if not isSwap then
        div []
        [ img [onClick <| Msgs.FetchGame Nothing Nothing (ChooseGameType Swap)
        , src (imgSourcePath ++ "swap_icon.png") 
        ] []
        , img [onClick <| Msgs.FetchGame Nothing Nothing (ChooseGameType Up)
        , src (imgSourcePath ++ "obenabe.png") 
        ] []
        , img [onClick <| Msgs.FetchGame Nothing Nothing (ChooseGameType Down)
        , src (imgSourcePath ++ "undenufe.png") 
        ] []
        , img [onClick <| Msgs.FetchGame Nothing Nothing (ChooseGameType (Color "hearts"))
        , src (imgSourcePath ++ (colorTranslate German "hearts") ++ "_icon.png") 
        ] []
        , img [onClick <| Msgs.FetchGame Nothing Nothing (ChooseGameType (Color "diamonds"))
        , src (imgSourcePath ++ (colorTranslate German "diamonds") ++ "_icon.png") 
        ] []
        , img [onClick <| Msgs.FetchGame Nothing Nothing (ChooseGameType (Color "spades"))
        , src (imgSourcePath ++ (colorTranslate German "spades") ++ "_icon.png") 
        ] []
        , img [onClick <| Msgs.FetchGame Nothing Nothing (ChooseGameType (Color "clubs"))
        , src (imgSourcePath ++ (colorTranslate German "clubs") ++ "_icon.png") 
        ] []
        ]    
    else 
        div []
        [ img [Msgs.FetchGame Nothing Nothing (ChooseGameType Up) |> onClick, src (imgSourcePath ++ "obenabe.png") ] []
        , img [Msgs.FetchGame Nothing Nothing (ChooseGameType Down) |> onClick, src (imgSourcePath ++ "undenufe.png") ] []
        , img [Msgs.FetchGame Nothing Nothing (ChooseGameType (Color "hearts")) |> onClick, src (imgSourcePath ++ (colorTranslate German "hearts") ++ "_icon.png") ] []
        , img [Msgs.FetchGame Nothing Nothing (ChooseGameType (Color "diamonds")) |> onClick, src (imgSourcePath ++ (colorTranslate German "diamonds") ++ "_icon.png") ] []
        , img [Msgs.FetchGame Nothing Nothing (ChooseGameType (Color "spades")) |> onClick, src (imgSourcePath ++ (colorTranslate German "spades") ++ "_icon.png") ] []
        , img [Msgs.FetchGame Nothing Nothing (ChooseGameType (Color "clubs")) |> onClick, src (imgSourcePath ++ (colorTranslate German "clubs") ++ "_icon.png") ] []
        ]


viewGameState : Game ->  Html Msg
viewGameState game =
    div [] 
    [ h1 [] [viewGameType game.gameType]
    , h2 [] [text game.activePlayer]
    , h2 [] [text ("Round #" ++ (toString (game.round, game.turn)))]
    , ol [class "list-reset"] (viewPlayerCards game.cardsPlayer)
    , ol [class "list-reset"] (viewPlayers game.activePlayer game.onTurnPlayer game.players)
    , viewTable game.table
    , div [] 
        [ viewGroup (List.head game.groups)
        , viewGroup (List.head (unwrapMaybeGroups (List.tail game.groups)))
        ]
    ]

viewOnTurnGameState : Game -> Html Msg
viewOnTurnGameState game =
    div [] 
    [ h1 [] [viewGameType game.gameType]
    , h2 [] [text game.activePlayer]
    , h2 [] [text ("Round #" ++ (toString (game.round, game.turn)))]
    , ol [class "list-reset"] (viewOnTurnPlayerCards game.cardsPlayer)
    , ol [class "list-reset"] (viewPlayers game.activePlayer game.onTurnPlayer game.players)
    , viewTable game.table
    , div [] 
        [ viewGroup (List.head game.groups)
        , viewGroup (List.head (unwrapMaybeGroups (List.tail game.groups)))
        ]
    ]

viewGameType : GameType -> Html Msg
viewGameType gameType =
    case gameType of
        NoGameType ->
            div [] [img  [src (imgSourcePath ++ "question_mark.png")] [] ]
        Swap ->
            div [] [img [src (imgSourcePath ++ "swap_icon.png")] []]
        Up ->
            div [] [img  [src (imgSourcePath ++ "obenabe.png")] [] ]
        Down ->
            div [] [img [src (imgSourcePath ++ "undenufe.png")] [] ]
        Color color ->
            div [] [img [src (imgSourcePath ++ (colorTranslate German color)++ "_icon.png") ] []]

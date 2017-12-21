module Game.Model exposing (..)
{-
    @moduledoc
    Provides types for everything that is game related.
-}

{-
    Every necessary information about the game is stored here.
    Those are:
    GameType ==> What kind of Game it is (Herz Trumpf etc.)
    Round ==> After 4 player cards, the round is increased by 1
    Turn ==> Increases from 0 to 4 each round
    players ==> List of players that play the game.
    groups ==> Two groups
    activePlayer ==> Player from whose PoV the game is rendered
    onTurnPlayer ==> Player who will play next.
    cardsPlayer ==> A list of cards the player owns.
    table ==> stores which cards lie on the table.
-}

type Language
    = German
    | French

type alias Game =
    { gameType : GameType
    , round : Int
    , turn : Int
    , players : List Player
    , groups : List Group
    , activePlayer : Player
    , onTurnPlayer : Player
    , cardsPlayer : Maybe ( List Card ) 
    , table : Table
    }
-- Stores a color and number (e.g. hearts ace)
type alias Card =
    { color : String
    , number : String 
    }

-- Id with which it is associated in the list
type alias GameId =
    String

-- Position of the game
type alias GameCoord =
    (Int, Int)

-- Players name
type alias Player =
    String
type alias Color =
    String
type alias Number =
    String

-- Cards that are owned by a group
type alias History =
    Maybe (List (List Card))

--Group stores the players that belong to it,
-- the points and the cards
type alias Group =
    { points : Int
    , players : List Player
    , wonCards : History
    }

-- every position stores one card (to be revised.)
type alias Table =
    { pos1 : Maybe Card 
    , pos2 : Maybe Card
    , pos3 : Maybe Card
    , pos4 : Maybe Card 
    }

-- When waiting for a game either the lobby is full
-- and gameInfo is there
-- or you're waiting for players
type Lobby 
    = GameInfo GameId
    | Players (List Player)

-- Internal gameType type
-- Every major GameType, important for choosing the gameType at the start.
type GameType
    = Swap
    | Color String
    | Up
    | Down
    | NoGameType

-- In the play section these are the three actions that can be taken.
type Action
    = ChooseGameType GameType
    | PlayCard Card
    | NoAction


type alias PlayerInput =
    (List Player, Player, Player)
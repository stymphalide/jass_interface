module Game.Model exposing (..)

type alias Game =
    { gameType : String
    , round : Int
    , turn : Int
    , players : List Player
    , groups : List Group
    , activePlayer : Player
    , onTurnPlayer : Player
    , cardsPlayer : Maybe ( List Card ) 
    , table : Table
    }
type alias Card =
    { color : String
    , number : Number 
    }

type alias GameId =
    String

type alias GameCoord =
    (Int, Int)

type alias Player =
    String
type alias Color =
    String
type alias Number =
    String
type alias History =
    Maybe (List (List Card))

type alias Group =
    { points : Int
    , players : List Player
    , wonCards : History
    }

type alias Table =
    { pos1 : Maybe Card 
    , pos2 : Maybe Card
    , pos3 : Maybe Card
    , pos4 : Maybe Card 
    }

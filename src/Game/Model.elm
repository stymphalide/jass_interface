module Game.Model exposing (..)

type alias Game =
    { gameType : String
    , round : Int
    , turn : Int
    , players : List Player
    , group : List Group
    , activePlayer : Player
    , onTurnPlayer : Player
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
    , wonCards : Maybe (List (List Card))
    }

type alias Table =
    { pos1 : Maybe Card 
    , pos2 : Maybe Card
    , pos3 : Maybe Card
    , pos4 : Maybe Card 
    }
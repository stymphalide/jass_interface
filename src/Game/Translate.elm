module Game.Translate exposing (..)

import List
import Tuple

{- TODO Explanation what this does, easier way!!!-}

colors_english = ["hearts", "spades", "diamonds", "clubs"]
numbers_english = ["6", "7", "8", "9", "10", "jack", "queen", "king", "ace"]

colors_german = ["Rose", "Schilte", "Eichle", "Schelle"]
numbers_german = ["6", "7", "8", "9", "10", "Under", "Ober", "K", "As"]

colors_french = ["Herz", "Schaufel", "Ecke", "Kreuz"]
numbers_french = ["6", "7", "8", "9", "10", "Bauer", "Dame", "K", "Ass"]

mappedColors : List (String, String)
mappedColors =
    List.map2 (,) colors_english colors_german

mappedNumbers : List (String, String)
mappedNumbers =
    List.map2 (,) numbers_english numbers_german



colorTranslate : String -> String
colorTranslate color =
    Tuple.second (extractTuple color mappedColors)

numberTranslate : String -> String
numberTranslate number =
    Tuple.second (extractTuple number mappedNumbers)

extractTuple : String -> List(String, String) -> (String, String)
extractTuple a list = 
    case List.head (matchingTuple a list) of
        Just s ->
            s
        Nothing ->
            ("", "")


matchingTuple : String  -> List (String, String) -> List (String, String)
matchingTuple a list =
    List.filter (isEqualColor a) list

isEqualColor : String  -> ((String, String) -> Bool)
isEqualColor col =
    isEqual col


isEqual : String -> (String, String) -> Bool
isEqual a b =
    a == Tuple.first b

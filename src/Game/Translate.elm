module Game.Translate exposing (..)

import List
import Dict

{- TODO Explanation what this does, easier way!!!-}

colors_english = ["hearts", "spades", "diamonds", "clubs"]
numbers_english = ["6", "7", "8", "9", "10", "jack", "queen", "king", "ace"]

colors_german = ["Rose", "Schilte", "Eichle", "Schelle"]
numbers_german = ["6", "7", "8", "9", "10", "Under", "Ober", "K", "As"]

dict_colors_german =
    List.map2 Dict.singleton colors_english colors_german
dict_numbers_german =
    List.map2 Dict.singleton numbers_english numbers_german

-- Is not used (yet)
colors_french = ["Herz", "Schaufel", "Ecke", "Kreuz"]
numbers_french = ["6", "7", "8", "9", "10", "Bauer", "Dame", "K", "Ass"]

colorTranslate : String -> String
colorTranslate color =
    Tuple.second (extractTuple color mappedColors)

numberTranslate : String -> String
numberTranslate number =
    Tuple.second (extractTuple number mappedNumbers)

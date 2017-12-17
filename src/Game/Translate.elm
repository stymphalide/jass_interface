module Game.Translate exposing (..)

import List
import Dict exposing (..)
{- TODO Explanation what this does, easier way!!!-}

colors_english = ["hearts", "spades", "diamonds", "clubs"]
numbers_english = ["6", "7", "8", "9", "10", "jack", "queen", "king", "ace"]

colors_german = ["Rose", "Schilte", "Eichle", "Schelle"]
numbers_german = ["6", "7", "8", "9", "10", "Under", "Ober", "K", "As"]

mapped_german_colors =
    List.map2 unite colors_english colors_german
mapped_german_numbers =
    List.map2 unite numbers_english numbers_german

unite : a -> b -> (a, b)
unite a b =
    (a, b)


dict_colors_german : Dict String String
dict_colors_german =
    fromList mapped_german_colors
dict_numbers_german :  Dict String String
dict_numbers_german =
    fromList mapped_german_numbers

-- Is not used (yet)
colors_french = ["Herz", "Schaufel", "Ecke", "Kreuz"]
numbers_french = ["6", "7", "8", "9", "10", "Bauer", "Dame", "K", "Ass"]

colorTranslate : String -> Maybe String
colorTranslate color =
    get color dict_colors_german


numberTranslate : String -> Maybe String
numberTranslate number =
    get number dict_numbers_german

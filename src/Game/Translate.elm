module Game.Translate exposing (..)
{-
    Translates the english names into german names
    (This is important for rendering purposes)
-}


import List
import Dict exposing (..)

colors_english : List String
colors_english = 
    ["hearts", "spades", "diamonds", "clubs"]

numbers_english : List String
numbers_english = 
    ["6", "7", "8", "9", "10", "jack", "queen", "king", "ace"]

colors_german : List String
colors_german = 
    ["Rose", "Schilte", "Eichle", "Schelle"]

numbers_german : List String
numbers_german = 
    ["6", "7", "8", "9", "10", "Under", "Ober", "K", "As"]

-- List of Tuples, where each english color is with its associated german color
mapped_german_colors : List (String, String)
mapped_german_colors =
    List.map2 unite colors_english colors_german
mapped_german_numbers : List (String, String)
mapped_german_numbers =
    List.map2 unite numbers_english numbers_german

-- helper function to create a tuple from a list
-- There might be a built in funciton?
unite : a -> b -> (a, b)
unite a b =
    (a, b)

-- From the tuples create a dict.
dict_colors_german : Dict String String
dict_colors_german =
    fromList mapped_german_colors
dict_numbers_german :  Dict String String
dict_numbers_german =
    fromList mapped_german_numbers

-- Is not used (yet)
colors_french = ["Herz", "Schaufel", "Ecke", "Kreuz"]
numbers_french = ["6", "7", "8", "9", "10", "Bauer", "Dame", "K", "Ass"]


-- Now the lookup is a simple get call.
colorTranslate : String -> String
colorTranslate color =
    case get color dict_colors_german of
        Nothing ->
            ""
        Just color ->
            color

numberTranslate : String -> String
numberTranslate number =
    case get number dict_numbers_german of
        Nothing ->
            ""
        Just number ->
            number

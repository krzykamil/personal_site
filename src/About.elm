module About exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)


view model =
    div [ class "jumbotron" ]
        [ h1 [] [ text "Welcome to My page" ]
        , p []
            [ text "KKP "
            , text <|
                """
                itsa me
                """
            ]
        ]


main =
    view "dummy model"

module App exposing (Intent(..), header)

import App.Route exposing (Route)
import Element exposing (Element, fill, height, px, rgb, width)
import Element.Background as Background
import Element.Border as Border
import Element.Region as Region


type Intent
    = EnterUserName String
    | EnterUserPassword String
    | InitiateLogin


type alias HeaderModel a =
    { a
        | route : Route
    }


header : HeaderModel a -> Element Intent
header { route } =
    Element.row
        [ Region.navigation
        , Border.color (rgb 0.2 0.2 0.2)
        , Border.solid
        , Border.widthEach
            { bottom = 0
            , left = 0
            , right = 0
            , top = 3
            }
        , width fill
        ]
        [ Element.el
            [ Background.color (Element.rgb 0.3 0.3 0.3)
            , height (px 50)
            , width (px 50)
            ]
            (Element.text "Logo")
        , Element.el
            [ Background.color (Element.rgb 0.4 0.4 0.4)
            , height (px 50)
            , width fill
            ]
            (Element.text "Navigation")
        ]

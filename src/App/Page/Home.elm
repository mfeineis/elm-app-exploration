module App.Page.Home exposing (view)

import App exposing (Intent(..))
import App.Session exposing (Session)
import Browser
import Element
    exposing
        ( Element
        , alignTop
        , el
        , fill
        , height
        , padding
        , px
        , rgb
        , scrollbarY
        , spacing
        , text
        , width
        )
import Element.Background as Background
import Element.Region as Region


type alias PageModel a =
    { a
        | session : Session
    }


view : PageModel a -> ( String, List (Element Intent) )
view model =
    ( "Home"
    , [ App.header
      , Element.row
          [ Region.mainContent
          , Background.color (rgb 0.8 0.8 0.8)
          , height fill
          , scrollbarY
          , width fill
          ]
          [ Element.wrappedRow
              [ alignTop
              , padding 20
              , spacing 20
              , width fill
              ]
              [ el
                  [ Background.color (rgb 0.7 0.7 0.7)
                  , height (px 200)
                  , width (px 200)
                  ]
                  Element.none
              , el
                  [ Background.color (rgb 0.7 0.7 0.7)
                  , height (px 200)
                  , width (px 200)
                  ]
                  Element.none
              , text "Homepage content"
              ]
          ]
      ]
    )


module App.Page.Home exposing (view)

import App exposing (Intent(..))
import App.Session exposing (Session)
import Browser
import Element exposing (Element, text)


type alias PageModel a =
    { a
        | session : Session
    }


view : PageModel a -> ( String, Element Intent )
view model =
    ( "Home", text "Homepage content" )


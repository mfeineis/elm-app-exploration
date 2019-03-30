module App.Session exposing (Session, default, login)

import Task


type Session
    = Authenticated SessionData
    | Indeterminate
    | Authenticating
    | Unauthenticated Int String


type alias SessionData =
    {
    }


default : Session
default =
    Indeterminate


login : (Session -> msg) -> String -> String -> ( Session, Cmd msg )
login toMsg userName userPassword =
    let
        sessionData =
            {
            }
    in
    ( Authenticating
    , Task.perform toMsg (Task.succeed (Authenticated sessionData))
    )


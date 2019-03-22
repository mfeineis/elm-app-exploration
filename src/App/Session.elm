module App.Session exposing (Session, default, init)

import Task


type Session
    = Session SessionData


type alias SessionData =
    { isValid : Bool
    }


default : Session
default =
    Session { isValid = False }


init : (Session -> msg) -> Cmd msg
init toMsg =
    let
        sessionData =
            { isValid = True
            }
    in
    Task.perform toMsg (Task.succeed (Session sessionData))

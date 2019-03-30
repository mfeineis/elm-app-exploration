module App.Page.Login exposing (view)

import App exposing (Intent(..))
import App.Route exposing (Route)
import App.Session exposing (Session)
import Browser
import Element
    exposing
        ( Element
        , alignTop
        , centerX
        , column
        , el
        , fill
        , height
        , maximum
        , padding
        , paragraph
        , px
        , rgb
        , row
        , scrollbarY
        , spacing
        , text
        , textColumn
        , width
        )
import Element.Background as Background
import Element.Input as Input
import Element.Region as Region


type alias PageModel a =
    { a
        | route : Route
        , session : Session
        , loginUserName : String
        , loginUserPassword : String
    }


view : PageModel a -> ( String, List (Element Intent) )
view model =
    ( "Login"
    , [ App.header model
      , Element.row
            [ Region.mainContent
            , Background.color (rgb 0.8 0.8 0.8)
            , height fill
            , scrollbarY
            , width fill
            ]
            [ column
                [ alignTop
                , centerX
                , padding 40
                , spacing 20
                , width (fill |> maximum 640)
                ]
                [ row
                    [ spacing 20
                    , width fill
                    ]
                    [ el
                        [ Background.color (rgb 0.7 0.7 0.7)
                        , height fill
                        , width (px 150)
                        ]
                        Element.none
                    , column
                        [ spacing 20
                        , width fill
                        ]
                        [ Input.text []
                            { label = Input.labelAbove [] (text "User Name")
                            , onChange = EnterUserName
                            , placeholder = Nothing
                            , text = model.loginUserName
                            }
                        , Input.currentPassword []
                            { label = Input.labelAbove [] (text "Password")
                            , onChange = EnterUserPassword
                            , placeholder = Nothing
                            , show = False
                            , text = model.loginUserPassword
                            }
                        ]
                    ]
                , Input.button
                    [ Background.color (rgb 0.7 0.7 0.7)
                    , width fill
                    ]
                    { label =
                        el
                            [ centerX
                            , padding 15
                            ]
                            (text "Login")
                    , onPress = canLogin model
                    }
                , column
                    [ Background.color (rgb 0.9 0.9 0.9)
                    , padding 20
                    , spacing 20
                    , width fill
                    ]
                    [ textColumn
                        []
                        [ paragraph
                            []
                            [ text "Don't already have an account?"
                            ]
                        ]
                    , Input.button
                        [ Background.color (rgb 0.7 0.7 0.7)
                        , width fill
                        ]
                        { label =
                            el
                                [ centerX
                                , padding 15
                                ]
                                (text "Register")
                        , onPress = Nothing
                        }
                    ]
                ]
            ]
      ]
    )


canLogin : { a | loginUserName : String, loginUserPassword : String } -> Maybe Intent
canLogin { loginUserName, loginUserPassword } =
    case String.length loginUserName > 0 && String.length loginUserPassword > 0 of
        True ->
            Just InitiateLogin

        False ->
            Nothing

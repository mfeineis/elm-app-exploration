module Main exposing (main)

import App exposing (Intent(..))
import App.Page.Home as Home
import App.Page.Login as Login
import App.Route as Route exposing (Route(..))
import App.Session as Session exposing (Session)
import Browser exposing (UrlRequest(..))
import Browser.Navigation as Nav
import Element
import Html
import Url exposing (Url)


type Fact
    = LinkClicked UrlRequest
    | SessionRenewed Session
    | UrlChanged Url


type alias Model =
    -- Login/Registration
    { loginUserName : String
    , loginUserPassword : String

    -- General stuff
    , navKey : Nav.Key
    , route : Route
    , session : Session
    }


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url navKey =
    -- Login/Registration
    ( { loginUserName = ""
      , loginUserPassword = ""

      -- General stuff
      , navKey = navKey
      , route = Login
      , session = Session.default
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


apply : Fact -> Model -> ( Model, Cmd Msg )
apply fact model =
    case fact of
        LinkClicked (External url) ->
            ( model, Cmd.none )

        LinkClicked (Internal url) ->
            ( { model | route = parseRoute url }, Cmd.none )

        SessionRenewed session ->
            ( { model | session = session }
            , Route.replaceUrl model.navKey Home
            )

        UrlChanged url ->
            ( { model | route = parseRoute url }, Cmd.none )


interpret : Intent -> Model -> ( Model, Cmd Msg )
interpret intent model =
    case intent of
        EnterUserName it ->
            ( { model | loginUserName = it }, Cmd.none )

        EnterUserPassword it ->
            ( { model | loginUserPassword = it }, Cmd.none )

        InitiateLogin ->
            let
                ( session, cmd ) =
                    Session.login
                        (Fact << SessionRenewed)
                        model.loginUserName
                        model.loginUserPassword
            in
            ( { model | session = session }, cmd )



-- VIEW


view : Model -> Browser.Document Msg
view ({ route } as model) =
    let
        adopt ( title, content ) =
            { body =
                [ Element.layout [ Element.width Element.fill ]
                    (Element.column
                        [ Element.height Element.fill
                        , Element.width Element.fill
                        ]
                        content
                    )
                    |> Html.map Intent
                ]
            , title = title ++ " - WhiteLabel"
            }
    in
    case route of
        Home ->
            adopt (Home.view model)

        Login ->
            adopt (Login.view model)



-- SETUP


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , onUrlChange = Fact << UrlChanged
        , onUrlRequest = Fact << LinkClicked
        , subscriptions = subscriptions
        , update = update
        , view = view
        }


type Msg
    = Fact Fact
    | Intent Intent


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Fact fact ->
            apply fact model

        Intent intent ->
            interpret intent model



-- HELPERS


parseRoute : Url -> Route
parseRoute url =
    Maybe.withDefault Home (Route.fromUrl url)

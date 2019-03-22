module Main exposing (main)

import App exposing (Intent(..))
import App.Page.Home as Home
import App.Route as Route exposing (Route(..))
import App.Session as Session exposing (Session)
import Browser exposing (UrlRequest(..))
import Browser.Navigation as Nav
import Element
import Html
import Url exposing (Url)


type alias Model =
    { route : Route
    , session : Session
    }


type Fact
    = LinkClicked UrlRequest
    | SessionRenewed Session
    | UrlChanged Url


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( { route = Home
      , session = Session.default
      }
    , Session.init (Fact << SessionRenewed)
    )


apply : Fact -> Model -> ( Model, Cmd Msg )
apply fact model =
    case fact of
        LinkClicked (External url) ->
            ( model, Cmd.none )

        LinkClicked (Internal url) ->
            ( { model | route = parseRoute url }, Cmd.none )

        SessionRenewed session ->
            ( { model | session = session }, Cmd.none )

        UrlChanged url ->
            ( { model | route = parseRoute url }, Cmd.none )


interpret : Intent -> Model -> ( Model, Cmd Msg )
interpret intent model =
    ( model, Cmd.none )


view : Model -> Browser.Document Msg
view ({ route } as model) =
    let
        adopt ( title, content ) =
            { body =
                [ Element.layout [] content
                    |> Html.map Intent
                ]
            , title = title ++ " - WhiteLabel"
            }
    in
    case route of
        Home ->
            adopt (Home.view model)



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

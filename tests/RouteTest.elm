module RouteTest exposing (suite)

import App.Route as Route exposing (Route(..))
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import Url exposing (Url)


suite : Test
suite =
    describe "Route"
        [ testUrl "" Home
        , testUrl "#login" Login
        ]


testUrl : String -> Route -> Test
testUrl hash expectedRoute =
    test ("Parsing hash '" ++ hash ++ "'") <|
        \() ->
            fragment hash
                |> Route.fromUrl
                |> Expect.equal (Just expectedRoute)


fragment : String -> Url
fragment frag =
    { protocol = Url.Http
    , host = "foo.com"
    , port_ = Nothing
    , path = "bar"
    , query = Nothing
    , fragment = Just frag
    }

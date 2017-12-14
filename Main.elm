module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)

main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }

type alias Model =
    { projects : List Project
    }

type alias Project =
    { name : String,
      url : String,
      readmeSnippet : String
    }

emptyModel : Model
emptyModel =
    { projects = []
    }

init : (Model, Cmd Msg)
init = emptyModel ! []

type Msg
    = NoOp

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        NoOp ->
            model ! []

view : Model -> Html Msg
view model =
    div
        [ class "dashboard-wrapper" ]
        [ text "Success!" ]

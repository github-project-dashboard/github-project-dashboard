module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Task

main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }

type alias Model =
    { projects : List Project,
      nameContent : String
    }

type alias Project =
    { name : String,
      url : String,
      readmeSnippet : String
    }

emptyModel : Model
emptyModel =
    { projects = []
    , nameContent = ""
    }

init : (Model, Cmd Msg)
init = emptyModel ! []

type Msg
    = UpdateName String
    | Submit
    | Send
    | Success
    | Noop

sendProject : String -> Task Error String
sendProject name = post Decode.string "http://localhost" empty

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        UpdateName name ->
            {model | nameContent = name} ! []
        Submit ->
            let
                project = {name = model.nameContent, url = "", readmeSnippet = ""}
            in
                {model | projects = project::model.projects} ! []
        Send ->
            let
                handleError _ = Noop
                handleVal _ = Success
            in
                Task.perform handleError handleVal <| sendProject

view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "text", placeholder "Test", onInput UpdateName ] []
        , button [ onClick Submit ] [ text "Submit" ]
        , div [] [ text <| Maybe.withDefault "" <| Maybe.map .name <| List.head model.projects ]
        ]

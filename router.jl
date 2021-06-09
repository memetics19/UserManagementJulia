using Bukdu
import Bukdu.Actions: index, show, new, edit, create, delete, update, HTTP

include("src/UserAuth/UserAuth.jl")
include("src/db/config.jl")


routes() do 
    Bukdu.options("/", AuthenticationController, take_options)
    Bukdu.options("/token", AuthenticationController, take_options)
    plug(Plug.Parsers, json=Plug.ContentParsers.JSONDecoder)
    post("/token",AuthenticationController,GenerateAccessToken) 
    get("/connect",ConnectionController,redisconnection)
    # get("/raw",AuthenticationController,GenerateSchemaUsers)
end 

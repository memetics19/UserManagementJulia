
using Octo.Adapters.PostgreSQL,JSONWebTokens, Bukdu, JWTs, Random, UUIDs,HTTP,Base,Logging,Nettle
include("../db/config.jl")




struct AuthenticationController <: ApplicationController
    conn::Conn
end



struct UserException <: Exception
    var::Symbol
end 


custom_error= Base.showerror(e::UserException) = print(e.var, "User not Authenticated")

function take_options(c::AuthenticationController)
    req = c.conn.request
    @info :req_headers req.headers
    @info :req_method_target (req.method, req.target)
    nothing
end

function GenerateAccessToken(email,name,role,age,claims_dict)
    @info  :json email,name,role,age
    encoding = JSONWebTokens.HS256("secretkey") 
    access_token = JSONWebTokens.encode(encoding, claims_dict)
    return Dict("Access Token"=>access_token)
  
end



function hash_password(password)
    return hexdigest("sha256",password)
end 


function GenerateAccessToken(c::AuthenticationController)
        @info "Payload Received"
    try 
    password = c.params.password
    hash = hash_password(password)
    claims_dict = Dict("email" => c.params.email, "name" => c.params.name, "role" => c.params.role, "age" => c.params.age)
    if !isa(claims_dict,Dict{String, Nothing}) == true
        output = GenerateAccessToken(c.params.email,c.params.name,c.params.role,c.params.age,claims_dict)
             render(JSON,Dict("access token"=>output,"password"=>hash))
    else 
        render(JSON,Dict("401"=>"Unauthorized"))
    end

catch 
    @error "internal server error"
end
end 






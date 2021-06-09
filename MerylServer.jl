using Meryl 
@route POST "/get" () begin
    HTTP.Response(200, string(request.params["email","name","age","role"]))
end

start(host = "127.0.0.1", port = 8086, verbose = true)
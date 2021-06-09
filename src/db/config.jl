
using Redis, Bukdu


struct ConnectionController <: ApplicationController
  conn::Conn
end



function  dbconnection()
  return Repo.connect(
    adapter = Octo.Adapters.PostgreSQL,
    dbname = "",
    user = "",
    password = "",
    host = "",
    port = ""
)

end



function redisconnection(c::ConnectionController)
  redis = RedisConnection(host="",port = 6379)
  set(redis, "foo", "bar")
  res = get(conn, "foo")
  render(JSON, Dict("Connection" => res))

end




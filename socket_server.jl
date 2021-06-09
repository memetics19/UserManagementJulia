using Sockets 
    IPAddr = "" # yet to add 
    host = "" #yet to add
    server = Sockets.listen(Sockets.InetAddr(parse(IPAddr, host), port))
    @async HTTP.listen(f, host, port; server=server)
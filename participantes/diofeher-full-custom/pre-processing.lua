local incr = 1
core.register_service("pre_processing", "http", function(applet)
    applet:set_status(201)
    applet:start_response()
    applet:send("")
    
    -- Send to the instances
    local urls = { 'unix@/tmp/api1.sock', 'unix@/tmp/api2.sock' }
    local addr = urls[incr]
    incr = (incr & 1) + 1  -- ;)
    
    local socket = core.tcp()
    -- Connect to the service and send the request
    socket:connect(addr) 
    data = applet:receive()
    local req = 'POST /payments HTTP/1.1\r\nConnection: keep-alive\r\nContent-Type: application/json\r\nHost: localhost\r\nContent-Length: '.. applet.length .. '\r\n\r\n' ..data
    socket:send(req)
    socket:close()
end)

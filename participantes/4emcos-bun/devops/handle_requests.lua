local ngx_req = ngx.req
local ngx_timer = ngx.timer
local ngx_socket = ngx.socket
local string_format = string.format
local shared = ngx.shared.route_selector

ngx_req.read_body()
local data = ngx_req.get_body_data()

if not data then
    local tmp = ngx_req.get_body_file()
    if tmp then
        local f = io.open(tmp, "rb")
        if f then
            data = f:read("*a")
            f:close()
        end
    end
end

ngx.status = 201
ngx.header.content_length = 0
ngx.eof()

if not data or #data == 0 or #data > 10240 then
    return
end

local turn = shared:incr("turn", 1, 0) or 1
local idx = turn % 2

local primary = (idx == 0) and "unix:/tmp/backend_1.sock" or "unix:/tmp/backend_2.sock"
local secondary = (idx == 1) and "unix:/tmp/backend_1.sock" or "unix:/tmp/backend_2.sock"

local http_request = string_format(
        "POST /payments HTTP/1.1\r\nHost: localhost\r\nContent-Type: application/json\r\nContent-Length: %d\r\nConnection: keep-alive\r\n\r\n%s",
        #data, data
)

local function forward(premature)
    if premature then
        return
    end

    local sock = ngx_socket.tcp()
    sock:settimeouts(100, 300, 300)
    local ok = sock:connect(primary)
    if not ok then
        ok = sock:connect(secondary)
    end

    if ok then
        local bytes, err = sock:send(http_request)
        if not bytes then
            shared:incr("errors", 1, 0)
        end
    else
        shared:incr("errors", 1, 0)
    end

    sock:close()
end

ngx_timer.at(0, forward)
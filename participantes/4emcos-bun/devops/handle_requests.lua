ngx.req.read_body()
local data = ngx.req.get_body_data()

if not data then
    local tmp = ngx.req.get_body_file()
    if tmp then
        local f = io.open(tmp, "rb")
        if f then
            data = f:read("*a")
            f:close()
        end
    end
end

ngx.status = 200
ngx.header.content_length = 0
ngx.eof()

if not data or data == "" then return end

local len = #data
local shared = ngx.shared.route_selector
local idx = (shared:incr("turn", 1, 0) or 1) % 2

local primary = (idx == 0) and "unix:/tmp/backend_1.sock" or "unix:/tmp/backend_2.sock"
local secondary = (idx == 0) and "unix:/tmp/backend_2.sock" or "unix:/tmp/backend_1.sock"

local http_request = string.format(
    "POST /payments HTTP/1.1\r\nHost: localhost\r\nContent-Type: application/json\r\nContent-Length: %d\r\nConnection: keep-alive\r\n\r\n%s",
    len, data
)

local function forward(premature)
    if premature then return end

    local sock = ngx.socket.tcp()
    sock:settimeouts(250, 500, 500)

    local ok = sock:connect(primary) or sock:connect(secondary)
    if ok then
        sock:send(http_request)
    end

    sock:close()
end

ngx.timer.at(0, forward)
local http = require("resty.http")
local cjson = require("cjson.safe")

ngx.req.read_body()
local body = ngx.req.get_body_data()
local httpc = http.new()
httpc:set_keepalive()
httpc:set_timeout(1500)

local function async_post(premature, rawBody)
    if premature then
        return
    end

    local decodedBody = cjson.decode(rawBody)

    local backends = {
        "http://backend-01:8080/payments/" .. tostring(decodedBody.amount),
        "http://backend-02:8080/payments/" .. tostring(decodedBody.amount)
    }

    local backend = backends[math.random(#backends)]

    httpc:request_uri(backend, {
        method = "POST",
        keepalive = true,
        keepalive_timeout = 60000,
        keepalive_pool = 1000,
    })

    ngx.sleep(0.001)
end

ngx.timer.at(0, async_post, body)

return ngx.exit(202)
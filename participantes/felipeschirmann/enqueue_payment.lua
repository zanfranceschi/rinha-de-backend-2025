-- Lê o corpo da requisição
ngx.req.read_body()
local body = ngx.req.get_body_data()

if not (body and string.len(body) > 0) then
    ngx.status = 400
    ngx.say("Request body is required")
    return ngx.exit(ngx.HTTP_BAD_REQUEST)
end

-- Carrega a biblioteca do Redis
local redis = require "resty.redis"
local red, err = redis:new()

if not red then
    ngx.log(ngx.ERR, "failed to instantiate redis: ", err)
    return ngx.exit(500)
end

-- Define timeouts para a conexão
red:set_timeouts(1000, 1000, 1000)

-- Conecta ao nosso serviço Redis. O nome 'redis' vem do docker-compose.
local ok, err = red:connect("redis", 6379)
if not ok then
    ngx.log(ngx.ERR, "failed to connect to redis: ", err)
    return ngx.exit(500)
end

-- Enfileira o pagamento usando LPUSH na nossa fila
local ok, err = red:lpush("payments:queue", body)
if not ok then
    ngx.log(ngx.ERR, "failed to send LPUSH to redis: ", err)
    return ngx.exit(500)
end

-- Devolve a conexão ao pool do OpenResty para ser reutilizada
local ok, err = red:set_keepalive(60000, 100)
if not ok then
    ngx.log(ngx.ERR, "failed to set keepalive: ", err)
end

-- Responde ao cliente com sucesso
return ngx.exit(202)

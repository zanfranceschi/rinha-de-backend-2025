local fromTs = ARGV[1] == '-inf' and '-inf' or tonumber(ARGV[1])
local toTs   = ARGV[2] == '+inf' and '+inf' or tonumber(ARGV[2])
local entries = redis.call('ZRANGEBYSCORE', KEYS[1], fromTs, toTs)
local res = {defaultCount=0, defaultSum=0, fallbackCount=0, fallbackSum=0}
for _, e in ipairs(entries) do
  local obj = cjson.decode(e)
  if obj.processor == 'default' then
    res.defaultCount = res.defaultCount + 1
    res.defaultSum   = res.defaultSum + obj.amount
  else
    res.fallbackCount = res.fallbackCount + 1
    res.fallbackSum   = res.fallbackSum + obj.amount
  end
end
return {res.defaultCount, res.defaultSum, res.fallbackCount, res.fallbackSum}

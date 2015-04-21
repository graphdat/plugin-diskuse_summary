local json = require('_json.lua')
local framework = require('framework.lua')
framework.table()
framework.util()
framework.functional()
local stringutil = framework.string

local Plugin = framework.Plugin
local NetDataSource = framework.NetDataSource
local net = require('net')
require('fun')(true) -- Shows a warn when overriding an existing function.

local items = {}

local params = framework.boundary.param
params.name = 'Boundary Disk Use Summary'
params.version = '2.0'

items = params.items or items

local meterDataSource = NetDataSource:new('127.0.0.1', '9192')

function meterDataSource:onFetch(socket)
	socket:write('{"jsonrpc":"2.0","method":"query_metric","id":1,"params":{"match":"system.fs.use_percent*"}}\n')
end

local meterPlugin = Plugin:new(params, meterDataSource)

function parse(data)
	return json:decode(data)
end

function meterPlugin:onParseValues(data)
	
	local result = {}
	local parsed = parse(data)
        if table.getn(parsed.result.query_metric) > 0 then
		for i = 1, table.getn(parsed.result.query_metric), 3 do
			if parsed.result.query_metric[i] ~= 'system.fs.use_percent.total' then
				local dirname = stringutil.urldecode(string.sub(parsed.result.query_metric[i], string.find(parsed.result.query_metric[i], "dir=")+4, string.find(parsed.result.query_metric[i], "&")-1))
				local devname = stringutil.urldecode(string.sub(parsed.result.query_metric[i], string.find(parsed.result.query_metric[i], "dev=")+4, -1))
				local sourcename=meterPlugin.source.."."
				local metric = {}
				local capture_metric = 0

				for _, item in ipairs(items) do
					if item.dir  then
						if (item.dir == dirname) then
							if item.device then
								if (item.device == devname) then
									capture_metric = 1
									sourcename = sourcename..(item.diskname or dirname.."."..devname)
								end
							else
								capture_metric = 1
								sourcename = sourcename..(item.diskname or dirname.."."..devname)
							end
						end
					elseif item.device and (item.device == devname) then
						capture_metric = 1
						sourcename = sourcename..(item.diskname or dirname.."."..devname)
					end
				end
				if capture_metric == 1 then
					metric.metric = "PERCENT_DISKUSE"
					metric.source = '"'..sourcename..'"'
					metric.value = parsed.result.query_metric[i+1]
					table.insert(result, metric)
				end
			end
		end
	end

	return result	

end

meterPlugin:run()

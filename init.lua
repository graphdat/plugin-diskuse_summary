-- Copyright 2015 Boundary, Inc.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--    http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--

local framework = require('framework.lua')
local Plugin = framework.Plugin
local MeterDataSource = framework.MeterDataSource
local notEmpty = framework.string.notEmpty
local isEmpty = framework.string.isEmpty
local pack = framework.util.pack
local urldecode = framework.string.urldecode
local params = framework.params
params.items = params.items or {} 

local ds = MeterDataSource:new()
function ds:onFetch(socket)
  socket:write(self:queryMetricCommand({match = "system.fs.use_percent" })) 
end

local plugin = Plugin:new(params, ds)

function plugin:onParseValues(data)
  local result = {}
  local source = self.source
  for i, v in pairs(data) do
    if v.metric == 'system.fs.use_percent.total' then
      result['DISKUSE_SUMMARY'] = { value = v.value, timestamp = v.timestamp }
    else
      local metric, rest = string.match(v.metric, '(system%.fs%.use_percent)|(.*)')
      if rest then
        local dir, dev = string.match(rest, '^dir=(.+)&dev=(.+)')
        dir = urldecode(dir)
        dev = urldecode(dev)
        for _, item in ipairs(params.items) do
          if (item.dir == dir and item.device == dev) or (item.dir and isEmpty(item.device) and item.dir == dir) or (isEmpty(item.dir) and item.device and item.device == dev) then
            source = self.source .. '.' .. (item.diskname or dir .. '.' .. dev)
            source = string.gsub(source, "([!@#$%%^&*() {}<>/\\|]", "-")
            table.insert(result, pack('DISKUSE_SUMMARY', v.value, v.timestamp, source))
            break
          end
        end
      end
    end
  end
  return result
end

plugin:run()


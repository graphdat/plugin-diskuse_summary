local os = require 'os'
local boundary = require 'boundary'
local io = require 'io'
local timer = require 'timer'
local _ = require 'underscore'

local param = boundary.param


local function check_device(device)
  local command = "df -k '"..device:gsub("'", "'\\''").."'"

  local df = io.popen(command)
  local result = df:read("*a")
  df:close()

  local index, _ = result:find('\n')

  local second_line = result:sub(index+1, -2):gsub("%s+", " ")

  local disk_info = {}

  for i in second_line:gmatch("%S+") do disk_info[#disk_info+1] = i end

  local total = disk_info[2]
  local free = disk_info[4]

  local percent_used = 1.0 - (free / total)
  
  return percent_used
end


local source = param.source or os.hostname();
local poll_interval = param.pollInterval or 3000;

timer.setInterval(poll_interval, function()
  local most_used = _(param.devices):chain():map(check_device):max():value()

	print(string.format("DISKUSE_SUMMARY %f", most_used))
end)


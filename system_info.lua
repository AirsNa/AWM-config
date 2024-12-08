local vicious = require("vicious")
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")


-- CPU usage
cpuwidget = wibox.widget.graph()
cpuwidget:set_background_color(wiget_bg_color)
cpuwidget:set_color(wiget_color)
vicious.register(cpuwidget, vicious.widgets.cpu, "$1", 4)

-- vicious.register(cpugraph, vicious.widgets.cpu,
--                  function (widget, args)
--                      return { args[2], args[3], args[4], args[5] }
--                  end, 1)


-- RAM usage
ramwidget = wibox.widget.graph()
ramwidget:set_background_color(wiget_bg_color)
ramwidget:set_color(wiget_color)
ramwidget:set_step_shape(gears.shape.line)
vicious.register(ramwidget, vicious.widgets.mem, "$1", 4)


-- SWAP usage
swapwidget = wibox.widget.graph()
swapwidget:set_background_color(wiget_bg_color)
swapwidget:set_color(wiget_color)
swapwidget:set_step_shape(gears.shape.line)
vicious.register(swapwidget, vicious.widgets.mem, "$5", 4)

-- TEMP
tempwidget = wibox.widget.graph()
tempwidget:set_width(40)
tempwidget:set_background_color(wiget_bg_color)
tempwidget:set_color(wiget_color)
vicious.register(tempwidget, vicious.widgets.hwmontemp, "$1", 4, { "amdgpu" })

-- DISK usage
diskbar = wibox.widget {
	max_value = 1,
	-- value = 0.7,
	widget = wibox.widget.progressbar(),
	forced_width = 10,
	forced_height = 15,
	color = wiget_color,
	background_color = wiget_bg_color,
}

vicious.register(
	diskbar,
	vicious.widgets.fs,
	function(widget, args)
		-- print(type(tonumber(string.format("%.2f", args["{/ used_gb}"] / args["{/ size_gb}"]))))
		return (args["{/ used_gb}"] * 100 / args["{/ size_gb}"])
	end,
	60
)

-- NETWORK bandwith (up/down)
netwiget = wibox.widget.textbox("leading ...")
-- vicious.register(netwiget, vicious.widgets.net, "↑${wlp1s0 up_kb}Kb ↓${wlp1s0 down_kb}kB", 5)
vicious.register(
	netwiget,
	vicious.widgets.net,
	function(widget, args)
		if tonumber(args["{" .. network_intrface .. " up_kb}"]) == 0.0 and tonumber(args["{" .. network_intrface .. " down_kb}"]) == 0.0 then
			return "N/A"
		end
		return "↑" ..
		args["{" .. network_intrface .. " up_kb}"] .. "Kb ↓" .. args["{" .. network_intrface .. " down_kb}"] .. "kB"
	end,
	5)


-- this is my old code
-- CPU USAGE INFO

-- local function getCPU()
-- 	local cpu_file = io.open("/proc/stat", 'r')
--
-- 	if cpu_file then
-- 		local line = cpu_file:read()
--
-- 		local user, nice, system, idle = line:match("cpu%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+)")
-- 		print(user, nice, system, idle)
-- 		cpu_file:close()
-- 		return tonumber(user), tonumber(nice), tonumber(system), tonumber(idle)
-- 	end
-- 	return 0, 0, 0, 0
-- end
--
-- -- RAM + SWAP USAGE
-- local function getMEM()
-- 	local mem_file = io.open("/proc/meminfo", 'r')
-- 	local totalMem, freeMem, availableMem, freeSwap, totalSwap
-- 	if mem_file then
-- 		local lines = mem_file:lines()
-- 		local i = 0
-- 		for line in lines do
-- 			if line:match("MemTotal:") then
-- 				totalMem = line:match("%d+")
-- 			elseif line:match("MemFree:") then
-- 				freeMem = line:match("%d+")
-- 			elseif line:match("MemAvailable:") then
-- 				availableMem = line:match("%d+")
-- 			elseif line:match("SwapTotal:") then
-- 				totalSwap = line:match("%d+")
-- 			elseif line:match("SwapFree:") then
-- 				freeSwap = line:match("%d+")
-- 			end
-- 			if totalMem and freeMem and availableMem and freeSwap and totalSwap then
-- 				break
-- 			end
-- 		end
-- 		local used_mem = totalMem - availableMem
-- 		local mem_usage = (used_mem / totalMem) * 100
-- 		local used_swap = totalSwap - freeSwap
-- 		local swap_usage = (used_swap / totalSwap) * 100
-- 		print(string.format("memory used => %.2fGB", used_mem / 1000000))
-- 		print(string.format("memory usage => %.1f%%", mem_usage))
-- 		print(string.format("swap used => %.2fGB", used_swap / 1000000))
-- 		print(string.format("swap usage => %.1f%%", swap_usage))
-- 		return used_mem, mem_usage, used_swap, swap_usage
-- 	end
-- end
--
-- -- DISK USAGE
-- local function getDISK()
-- 	local handle = io.popen("df /")
-- 	local size, used, avail, percentage
-- 	if not handle then
-- 		return "100% used"
-- 	end
-- 	local result = handle:lines()
-- 	for line in result do
-- 		if line:match("/dev") then
-- 			size, used, avail, percentage = line:match("%s+(%d+)%s+(%d+)%s+(%d+)%s+(%d+%%)")
-- 			size = size / 1000000
-- 			used = used / 1000000
-- 			avail = avail / 1000000
-- 			break
-- 		end
-- 	end
-- 	handle:close()
-- 	return size, used, avail, percentage
-- end
--
--
-- -- TEMP graph
-- local function getTEMP()
-- 	local temperature_file = io.open("/sys/class/hwmon/hwmon2/temp1_input", 'r')
-- 	if not temperature_file then
-- 		return 0
-- 	end
-- 	local content = temperature_file:read('*a')
-- 	temperature_file:close()
-- 	return tonumber(content) / 1000
-- end
--
-- -- battery status and percentage
-- function getBATTERY()
-- 	local full_energy = io.open("/sys/class/power_supply/BAT0/energy_full", "r")
-- 	local now_energy = io.open("/sys/class/power_supply/BAT0/energy_now", "r")
-- 	local battery_status = io.open('/sys/class/power_supply/BAT0/status', 'r')
--
-- 	if full_energy and now_energy and battery_status then
-- 		-- Read the entire content of the file
-- 		local full_content = full_energy:read("*a")
-- 		local now_content = now_energy:read("*a")
-- 		local status = battery_status:read('*a')
-- 		full_energy:close()
-- 		now_energy:close()
-- 		local battery_percentage = (tonumber(now_content) * 100 ) / tonumber(full_content)
-- 		-- Update the widget's text with the content
-- 		return math.floor(battery_percentage), status
-- 	else
-- 		return 0, "not Charging"
-- 	end
-- end

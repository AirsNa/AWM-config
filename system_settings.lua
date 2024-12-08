local vicious = require("vicious")
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
require("topPanelActions")

-- Keyboard layout
keyboard_lyt = awful.widget.keyboardlayout()

-- Battery
batwidget = wibox.widget.textbox("loading...")
-- -- Register battery widget
vicious.register(batwidget, vicious.widgets.bat, "BT $1 $2", 10, "BAT0")

-- sound
soundwidget = wibox.widget.textbox("loading...")
vicious.register(
	soundwidget,
	vicious.widgets.volume,
	"VOL $1% $2",
	10,
	"Master")

-- brightness
local function getBrightness()
	local actual_value_cmd = io.popen("brightnessctl g")
	local max_value_cmd = io.popen("brightnessctl m")
	if not actual_value_cmd or not max_value_cmd then
		return "N/A"
	end
	local max = max_value_cmd:read("*a")
	local now = actual_value_cmd:read("*a")
	actual_value_cmd:close()
	max_value_cmd:close()
	return "BR " .. string.format("%.0f", now * 100 / max) .. "%"
end

brightness_widget = wibox.widget.textbox("loading...")
vicious.register(brightness_widget, getBrightness, "$1", 2)

-- Wifi
wifiwidget = wibox.widget.textbox("loading...")
vicious.register(wifiwidget, vicious.widgets.wifi, "WIFI ${ssid}", 2, network_intrface)

-- Bluetooth
local function getBluetooth()
	local status_cmd = io.popen("bluetooth")
	if not status_cmd then
		return "N/A"
	end
	local status = status_cmd:read("*a")
	status_cmd:close()
	if status:match("on") then
		return "BL ON"
	end
	return "BL OFF"
end
bluetooth_widget = wibox.widget.textbox("loading...")
vicious.register(bluetooth_widget, getBluetooth, "$1", 1)

-- Power bottons
power_controls = wibox.widget.textbox("POWER BUTTONS")

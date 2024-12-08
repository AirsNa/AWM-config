local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
require("system_info")
require("system_settings")
require("create_layout")


function setup_screen_left_wibox(s)
	local box_width = s.geometry.width * 0.08
	local box_height = s.geometry.height * 0.04
	local left_bar = wibox({
		position = "top",
		width = box_width,
		height = box_height,
		x = 5,
		y = 1,
		visible = true,
		ontop = true,
		shape = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, 30) end
		,
		screen = s
	})

	left_bar:setup {
		-- layoutbox
		{
			createLayoutbox(s),
			left   = box_width * 0.1,
			layout = wibox.container.margin
		},
		-- active tag (1->9)
		{
			layout = wibox.layout.flex.horizontal,
			wibox.widget.textbox("Active Tag"),
			spacing = 10,
			spacing_widget = wibox.widget.separator,
		},
		layout = wibox.layout.flex.horizontal,
	}
	return left_bar
end

function setup_screen_middle_wibox(s)
	local bar_width = s.geometry.width * 0.4
	local bar_height = s.geometry.height * 0.04
	local start_x = (s.geometry.width / 2) - (bar_width / 2)
	local middle_bar = wibox({
		position = "top",
		width = bar_width,
		height = bar_height,
		x = start_x,
		y = 1,
		ontop = true,
		visible = true,
		shape = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, 30) end
		,
		screen = s
	})
	middle_bar:setup {

		-- Notification will take 30%
		-- clock        will take 20%
		-- system info  will take 50%

		{
			-- wibox.widget.textbox(""),
			wibox.widget {
				widget = wibox.widget.textbox,
				forced_width = bar_width * 0.3,
				text = "Notification",
			},
			left   = 10,
			-- right  = 40,
			layout = wibox.container.margin
		},
		{
			wibox.widget {
				widget = wibox.widget.textclock(),
				forced_width = bar_width * 0.2,
			},
			-- left = 10,
			-- right = 20,
			layout = wibox.container.margin
		},
		-- CPU
		{
			{
				cpuwidget,
				cpuwidget:set_width(bar_width / 18),
				top = 2,
				bottom = 2,
				left = 2,
				right = 2,
				layout = wibox.container.margin
			},
			{
				wibox.widget.textbox("CPU"),
				bottom = bar_height * 0.7,
				layout = wibox.container.margin
			},
			layout = wibox.layout.stack
		},

		-- RAM
		{
			{
				ramwidget,
				ramwidget:set_width(bar_width / 18),
				top = 2,
				bottom = 2,
				left = 2,
				right = 2,
				layout = wibox.container.margin
			},
			{
				wibox.widget.textbox("RAM"),
				bottom = bar_height * 0.7,
				layout = wibox.container.margin
			},
			layout = wibox.layout.stack
		},
		-- SWAP
		{
			{
				swapwidget,
				swapwidget:set_width(bar_width / 18),
				top = 2,
				bottom = 2,
				left = 2,
				right = 2,
				layout = wibox.container.margin
			},
			{
				wibox.widget.textbox("SWAP"),
				bottom = bar_height * 0.7,
				layout = wibox.container.margin
			},
			layout = wibox.layout.stack
		},
		-- TEMP
		{
			{
				tempwidget,
				tempwidget:set_width(bar_width / 18),
				top = 2,
				bottom = 2,
				left = 2,
				right = 2,
				layout = wibox.container.margin
			},
			{
				wibox.widget.textbox("Temp"),
				bottom = bar_height * 0.7,
				layout = wibox.container.margin
			},
			layout = wibox.layout.stack
		},
		{
			wibox.widget.textbox("Disk :"),
			top = 2,
			bottom = 2,
			left = 5,
			right = 2,
			layout = wibox.container.margin
		},

		-- STORAGE
		{
			diskbar,
			direction = 'east',
			layout = wibox.container.rotate
		},

		-- NETWORK
		{
			wibox.widget.textbox("Net :"),
			top = 2,
			bottom = 2,
			left = 5,
			right = 2,
			layout = wibox.container.margin
		},
		{
			netwiget,
			top = 2,
			bottom = 2,
			left = 5,
			right = 2,
			layout = wibox.container.margin
		},
		layout = wibox.layout.fixed.horizontal
	}
	return middle_bar
end

function setup_screen_right_wibox(s)
	local box_width = s.geometry.width * (20 / 100)
	local box_height = s.geometry.height * (4 / 100)
	local start_x = s.geometry.width - box_width - 5
	local right_bar = wibox({
		position = "top",
		width = box_width,
		height = box_height,
		x = start_x,
		y = 1,
		ontop = true,
		visible = true,
		shape = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, 30) end
		,
		screen = s
	})

	batwidget:buttons(
		awful.button({}, 1, function()
			showBatterystatus(s, start_x + step, box_height + 3)
		end
		)
	)
	soundwidget:buttons(
		awful.button({}, 1, function()
			showBatterystatus(s, start_x + 2 * step, box_height + 3)
		end
		)
	)
	brightness_widget:buttons(
		awful.button({}, 1, function()
			showBatterystatus(s, start_x + 3 * step, box_height + 3)
		end
		)
	)
	wifiwidget:buttons(
		awful.button({}, 1, function()
			showBatterystatus(s, start_x + 8 * step, box_height + 3)
		end
		)
	)
	bluetooth_widget:buttons(
		awful.button({}, 1, function()
			showBatterystatus(s, start_x + 16 * step, box_height + 3)
		end
		)
	)
	power_controls:buttons(
		awful.button({}, 1, function()
			showBatterystatus(s, start_x + 32 * step, box_height + 3)
		end
		)
	)
	right_bar:setup
	{
		-- KEYBOARD layout
		{
			keyboard_lyt,
			top = 5,
			bottom = 5,
			left = 10,
			right = 10,
			layout = wibox.container.margin
		},
		-- BATTERY icon
		{
			batwidget,
			top = 5,
			bottom = 5,
			left = 10,
			right = 10,
			layout = wibox.container.margin
		},
		-- SOUND icon
		{
			soundwidget,
			top = 5,
			bottom = 5,
			left = 10,
			right = 10,
			layout = wibox.container.margin
		},
		-- BRIGHTNESS icon
		{
			brightness_widget,
			top = 5,
			bottom = 5,
			left = 10,
			right = 10,
			layout = wibox.container.margin
		},
		-- WIFI icon
		{
			wifiwidget,
			top = 5,
			bottom = 5,
			left = 10,
			right = 10,
			layout = wibox.container.margin
		},
		-- BLUETOOTH icon
		{
			bluetooth_widget,
			top = 5,
			bottom = 5,
			left = 10,
			right = 10,
			layout = wibox.container.margin
		},
		-- POWER icon
		{
			power_controls,
			top = 5,
			bottom = 5,
			left = 10,
			right = 10,
			layout = wibox.container.margin
		},
		layout = wibox.layout.fixed.horizontal
	}
	return right_bar
end

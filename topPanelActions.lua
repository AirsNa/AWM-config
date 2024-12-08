local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local vicious = require("vicious")

function showBatterystatus(s, st_x, st_y)
	local p = awful.popup {
		widget              = {
			{
				{
					text   = 'foobar',
					widget = wibox.widget.textbox
				},

				layout = wibox.layout.fixed.vertical,
			},
			top = 10,
			bottom = 10,
			left = 10,
			right = 10,
			margin = 10,
			widget = wibox.container.margin
		},
		shape               = gears.shape.rounded_rect,
		border_width        = 1,
		border_color        = br_color,
		visible             = true,
		ontop               = true,
		hide_on_right_click = true,
		x                   = st_x,
		y                   = st_y,

	}
	-- p:move_next_to(parent)
end

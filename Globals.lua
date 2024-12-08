local awful = require("awful")

_G.context = {beautiful = nil}
Terminal = 'xterm'
Editor = 'nvim'

wiget_color = {
			type = "linear",
			from = { 0, 0 }, to = { 50, 0 },
            stops = { { 0, "#6d94c3" },
					{ 0.6, "#b28444" },
                    { 1, "#ca4124" } } }
wiget_bg_color = "#444444"
br_color = "#cd1c58"

step = 20

network_intrface = "wlp1s0"

-- Define your Mod key (usually "Mod4" = Super/Windows key)
SuperKey = "Mod4"

Layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}

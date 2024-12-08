-- Load required libraries
local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Define your Mod key (usually "Mod4" = Super/Windows key)
local SuperKey = "Mod4"

local editor_cmd = Terminal .. " -e " .. Editor

-- function needed by some keys

local myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", Terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

local mymainmenu = awful.menu({
			items = {
			-- { "awesome", myawesomemenu, _G.context.beautiful.awesome_icon },
			{ "restart", awesome.restart },
            { "open Terminal", Terminal }
        }
    })

-- Table to store all keybindings
local globalkeys = gears.table.join(
    -- General AwesomeWM bindings
    awful.key({ SuperKey }, "s", hotkeys_popup.show_help,
        { description = "show help", group = "awesome" }),
    awful.key({ SuperKey, "Shift" }, "w", function() mymainmenu:show() end,
        { description = "show main menu", group = "awesome" }),

    -- Tag navigation
    awful.key({ SuperKey }, "Left", awful.tag.viewprev,
        { description = "view previous tag", group = "tag" }),
    awful.key({ SuperKey }, "Right", awful.tag.viewnext,
        { description = "view next tag", group = "tag" }),
    awful.key({ SuperKey }, "Escape", awful.tag.history.restore,
        { description = "go back", group = "tag" }),

    -- Client focus
    awful.key({ SuperKey }, "j", function() awful.client.focus.byidx(1) end,
        { description = "focus next by index", group = "client" }),
    awful.key({ SuperKey }, "k", function() awful.client.focus.byidx(-1) end,
        { description = "focus previous by index", group = "client" }),

    -- Layout manipulation
    awful.key({ SuperKey, "Shift" }, "j", function() awful.client.swap.byidx(1) end,
        { description = "swap with next client by index", group = "client" }),
    awful.key({ SuperKey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end,
        { description = "swap with previous client by index", group = "client" }),
    awful.key({ SuperKey, "Control" }, "j", function() awful.screen.focus_relative(1) end,
        { description = "focus the next screen", group = "screen" }),
    awful.key({ SuperKey, "Control" }, "k", function() awful.screen.focus_relative(-1) end,
        { description = "focus the previous screen", group = "screen" }),

    -- Standard programs
    awful.key({ SuperKey }, "Return", function() awful.spawn(Terminal) end,
        { description = "open a Terminal", group = "launcher" }),
    awful.key({ SuperKey, "Shift" }, "r", awesome.restart,
        { description = "reload awesome", group = "awesome" }),
    -- awful.key({ SuperKey, "Shift" }, "q", awesome.quit,
    --     { description = "quit awesome", group = "awesome" }),

    -- Resize and layout
    awful.key({ SuperKey }, "l", function() awful.tag.incmwfact(0.05) end,
        { description = "increase master width factor", group = "layout" }),
    awful.key({ SuperKey }, "h", function() awful.tag.incmwfact(-0.05) end,
        { description = "decrease master width factor", group = "layout" }),
    awful.key({ SuperKey, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end,
        { description = "increase the number of master clients", group = "layout" }),
    awful.key({ SuperKey, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end,
        { description = "decrease the number of master clients", group = "layout" }),
    awful.key({ SuperKey, "Control" }, "h", function() awful.tag.incncol(1, nil, true) end,
        { description = "increase the number of columns", group = "layout" }),
    awful.key({ SuperKey, "Control" }, "l", function() awful.tag.incncol(-1, nil, true) end,
        { description = "decrease the number of columns", group = "layout" }),
    awful.key({ SuperKey }, "space", function() awful.layout.inc(1) end,
        { description = "select next layout", group = "layout" }),
    awful.key({ SuperKey, "Shift" }, "space", function() awful.layout.inc(-1) end,
        { description = "select previous layout", group = "layout" }),

    -- Custom Keybindings
    awful.key({ SuperKey, "Shift" }, "n", function()
        awful.spawn("notify-send 'Custom Notification' 'Keybinding Triggered'")
    end, { description = "show a notification", group = "custom" })
)

-- Return the global keys
return globalkeys


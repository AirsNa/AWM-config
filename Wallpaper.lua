local gears=require("gears")

local wallpaper_path = "./wallpaper.jpeg"

function set_wallpaper(s)
	gears.wallpaper.maximized(wallpaper_path, s)
end

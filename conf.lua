function love.conf(t)
    t.window.title = "Tower jam"        -- The title of the window the game is in (string)
	t.window.width = 768 --384
    t.window.height = 576 --288
    t.console = true           -- Attach a console (boolean, Windows only)
    t.release = false           -- Enable release mode (boolean)
    t.window.vsync = false       -- Enable vertical sync (boolean)
    t.window.fsaa = 0           -- The number of FSAA-buffers (number)
end
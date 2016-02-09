--[[
	standard configuration file with PAL screen size
]]--

function love.conf(t)
	t.screen = t.screen or t.window
	
	t.title = "Tower Jam"
	io.stdout:setvbuf("no")
	
	t.screen.width = 768
	t.screen.height = 576
	t.screen.borderless = false  
	t.screen.resizable = false  
	t.screen.fullscreen = false 
	t.screen.vsync = false       
	t.screen.fsaa = 0   
	--t.screen.icon = 0

	--disable unused modules
	
	--t.modules.joystick = false           -- Enable the joystick module (boolean)
    --t.modules.physics = false            -- Enable the physics module (boolean)
end
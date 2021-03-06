--[[
	standard configuration file with PAL screen size
]]--

function love.conf(t)
	t.screen = t.screen or t.window
	
	t.title = "Carcerato"
	io.stdout:setvbuf("no")
	
	t.screen.width = 768
	t.screen.height = 576
	t.screen.borderless = false  
	t.screen.resizable = false  
	t.screen.fullscreen = false 
	t.screen.vsync = false       
	t.screen.fsaa = 0   
	t.screen.icon = "Media/rock.png"
end
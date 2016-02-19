--[[
	This class holds the main menu state.
]]--

State_Main = {}

function State_Main:create()
	local new = {}
	setmetatable(new,self)
	self.__index = self

	new.timer = 0
	new.go = false

	main_background = love.graphics.newImage("Media/menu_bg.png")
	--buttons
	con = Button:create("Start game",{} ,love.graphics.getHeight()-220)

	qut = Button:create("Quit game" ,{} ,love.graphics.getHeight()-130)

	new.buttons = { con, qut}
	--this holds the bindings and name of the keys or buttons
	--					NAME			KEY		BUTTON	PRESSED
	new.bindings =  {{"Continue",	"",		3,		true},
					    {"Quit",		"escape",	5,		false}}
	
	return new
end

function State_Main:update(dt)
	--draw buttons
	for i,v in ipairs(self.buttons) do
		v:update()
	end

	if(self.timer > 0.5) then
		
		--self.go = false
		transition:go(self.button_start)
		--self.button_start()
	end
	if(self.go) then
		self.timer = self.timer + dt/3
	end
	
end

function State_Main:draw()
	local fade = 1- self.timer
	love.graphics.setColor(255*fade,255*fade,255*fade)
	love.graphics.setFont(font_title)
	
	love.graphics.draw(main_background,-self.timer*1600,-self.timer*50,0,2+self.timer*5)
	love.graphics.print("Carcerato", 50, 50)
	--draw buttons
	if(not self.go) then
		love.graphics.setFont(font)
		for i,v in ipairs(self.buttons) do
			v:draw()
		end
	end
end

		--input handling--
function State_Main:movement(x,y)

end

function State_Main:mouse(x, y, mouseButton, pressed)
	--update button
	for i,v in ipairs(self.buttons) do
		v:action(x, y, mouseButton, pressed)
	end
end

function State_Main:key(name)
	if 		name == "Continue" then
		stateIndex = 2

	elseif	name == "Quit" then
		print("Thanks for playing, shutting down system")
		love.event.quit()
	end
end

function State_Main:button(name, set)
	if 	name == "Start game" then
		self.go = true
	elseif name == "instructions" then
		stateIndex = 7
	elseif name == "Quit game" then
		print("Thanks for playing, shutting down system")
		transition:go(love.event.quit)
	end
end

function State_Main.button_start()
	states[stateIndex].timer = 0
	states[stateIndex].go = false
	stateIndex = 2
	states[stateIndex]:reset()
end
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
	con = Button:create("start game",{} ,love.graphics.getHeight()-160)
	opt = Button:create("options"   ,{} ,love.graphics.getHeight()-110)
	qut = Button:create("quit game" ,{} ,love.graphics.getHeight()-60)

	new.buttons = { con, opt, qut}
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

	if(self.timer > 0.2) then
		
		--self.go = false
		transition:go(self.button_start)
		--self.button_start()
	end
	if(self.go) then
		self.timer = self.timer + dt/2
	end
	
end

function State_Main:draw()
	love.graphics.setFont(font_title)
	love.graphics.draw(main_background,-self.timer*1600,-self.timer*50,0,2+self.timer*5)
	love.graphics.print("Carceralte", 50, 50)
	--draw buttons
	love.graphics.setFont(font)
	for i,v in ipairs(self.buttons) do
		v:draw()
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
	if 	name == "start game" then
		self.go = true
	elseif name == "instructions" then
		stateIndex = 7
	elseif name == "quit game" then
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
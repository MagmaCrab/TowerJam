--[[
	This class holds the in game menu state.
]]--

require "source/Button"

State_Menu = {}

function State_Menu:create()
	local new = {}
	setmetatable(new,self)
	self.__index = self
	
	--initialise all buttons for the menu 
	con = Button:create("continue",{},150)
	bdl = Button:create("borderless",{"off","on"},250)
	qut = Button:create("back to main menu",{},300)

	new.buttons = { con, ful, bdl, qut}
	--this holds the bindings and name of the keys or buttons
	--					NAME		KEY		BUTTON	PRESSED
	State_Menu.bindings =  	{{"Back",	"escape",	10,		false}
						}
	State_Menu:reset()
	return new
end

function State_Menu:reset()
	temp       = love.graphics.newScreenshot()
	screenshot = love.graphics.newImage(temp )
end

function State_Menu:update(dt)
	--update buttons
	for i,v in ipairs(self.buttons) do
        v:update()
	end
end

function State_Menu:draw()
	--draw background and menu
	love.graphics.draw(screenshot,0,0)
	love.graphics.setColor(0,0,0,200)
	love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())	
	love.graphics.setColor(255,255,255)
	love.graphics.printf("PAUSED",0,100,768,"center")
	
	--draw buttons
	for i,v in ipairs(self.buttons) do
        v:draw()
	end
end

		--input handling--
function State_Menu:movement(x,y)

end

function State_Menu:mouse(x, y, mouseButton, pressed)
	--update button
	for i,v in ipairs(self.buttons) do
		v:action(x, y, mouseButton, pressed)
	end
end

function State_Menu:key(name)
	if 		name == "Back" then
		stateIndex = 2
	end
end

function State_Menu:button(name,set)
	if 		name == "continue" then
		stateIndex = 2
	elseif name == "back to main menu" then
		stateIndex = 1
	elseif name == "borderless" then
		if set == "on" then
			love.window.setMode( love.graphics.getWidth(), love.graphics.getHeight(), {borderless = true})
		else
			love.window.setMode( love.graphics.getWidth(), love.graphics.getHeight(), {borderless = false})
		end
	end
end
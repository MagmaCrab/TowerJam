--[[
	This class holds the in game menu state.
]]--

State_End = {}

function State_End:create()
	local new = {}
	setmetatable(new,self)
	self.__index = self
	
	--initialise all buttons for the menu 
	qut = Button:create("Back to main menu",{},400)
	skull = love.graphics.newImage("Media/skull.png")

	new.buttons = {qut}
	--this holds the bindings and name of the keys or buttons
	--					NAME		KEY		BUTTON	PRESSED
	new.bindings =  	{{"Back",	"escape",	10,		false}
						}
	new:reset()
	return new
end

function State_End:reset()
	local temp = love.graphics.newScreenshot()
	screenshot = love.graphics.newImage(temp)
end

function State_End:update(dt)
	--update buttons
	for i,v in ipairs(self.buttons) do
        v:update()
	end
end

function State_End:draw()
	love.graphics.setFont(font)
	--draw background and menu
	love.graphics.draw(screenshot,0,0)
	love.graphics.setColor(50,0,0,200)
	love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())	
	love.graphics.setColor(255,255,255)
	love.graphics.draw(skull, 320, 225)
	love.graphics.printf("GAME OVER",0,100,768,"center")
	love.graphics.printf("You didn't manage to escape the tower.",0,150,768,"center")
	
	--draw buttons
	for i,v in ipairs(self.buttons) do
        v:draw()
	end
end

--input handling--
function State_End:movement(x,y)

end

function State_End:mouse(x, y, mouseButton, pressed)
	--update button
	for i,v in ipairs(self.buttons) do
		v:action(x, y, mouseButton, pressed)
	end
end

function State_End:key(name)

end

function State_End:button(name,set)
	if name == "Back to main menu" then
		transition:go(function () stateIndex = 1 end)
	end
end
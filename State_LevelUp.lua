--[[
	This class holds the in game menu state.
]]--

State_LevelUp = {}

function State_LevelUp:create()
	local new = {}
	setmetatable(new,self)
	self.__index = self
	
	new.buttons = {}
	-- choose 3 upgrades
	for i=1, 3 do
		table.insert(new.buttons, Button:create("upgrade 1",{},150 + i*75))
	end

	--this holds the bindings and name of the keys or buttons
	--					NAME		KEY		BUTTON	PRESSED
	new.bindings =  	{{"Back",	"escape",	10,		false}
						}
	new:reset()
	return new
end

function State_LevelUp:reset()
	local temp = love.graphics.newScreenshot()
	screenshot = love.graphics.newImage(temp )
end

function State_LevelUp:update(dt)
	--update buttons
	for i,v in ipairs(self.buttons) do
        v:update()
	end
end

function State_LevelUp:draw()
	love.graphics.setFont(font)
	--draw background and menu
	love.graphics.draw(screenshot,0,0)
	love.graphics.setColor(50,50,50,200)
	love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())	
	love.graphics.setColor(255,255,255)
	love.graphics.printf("CHOOSE UPGRADE",0,100,768,"center")
	
	--draw buttons
	for i,v in ipairs(self.buttons) do
        v:draw()
	end
end

		--input handling--
function State_LevelUp:movement(x,y)

end

function State_LevelUp:mouse(x, y, mouseButton, pressed)
	--update button
	for i,v in ipairs(self.buttons) do
		v:action(x, y, mouseButton, pressed)
	end
end

function State_LevelUp:key(name)

end

function State_LevelUp:button(name,set)
	transition:go(function () stateIndex = 2 end)
end
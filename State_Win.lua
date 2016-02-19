--[[
	This class holds the in game menu state.
]]--

State_Win = {}

function State_Win:create()
	local new = {}
	setmetatable(new,self)
	self.__index = self

	new.background = love.graphics.newImage("Media/win_bg.png")
	new.timer = love.graphics.getHeight()
	
	--initialise all buttons for the menu 
	local qut = Button:create("Back to main menu",{},love.graphics.getHeight()-60)

	new.buttons = {qut}
	--this holds the bindings and name of the keys or buttons
	--					NAME		KEY		BUTTON	PRESSED
	new.bindings =  	{{"Back",	"escape",	10,		false}
						}
	new:reset()
	return new
end

function State_Win:reset()
	self.timer = love.graphics.getHeight()
end

function State_Win:update(dt)
	if(self.timer>0) then
		self.timer = self.timer - dt*30
	else
		self.timer = 0
	end
	--update buttons
	for i,v in ipairs(self.buttons) do
        v:update()
	end
end

function State_Win:draw()
	local t = math.floor(self.timer)
	love.graphics.setFont(font)
	--draw background and menu
	love.graphics.setColor(255,255,255)
	love.graphics.draw(self.background,0,-love.graphics.getHeight()+t,0,2)
	love.graphics.printf("THANKS FOR PLAYING!"		,0,-80+t,768,"center")
	love.graphics.printf("Brought to you by"		,0,340+t,768,"center")
	love.graphics.printf("Hidde & Casper van Bavel",0,380+t,768,"center")
	
	--draw buttons
	for i,v in ipairs(self.buttons) do
		v.y = love.graphics.getHeight()-60+t
        v:draw()
	end
end

		--input handling--
function State_Win:movement(x,y)

end

function State_Win:mouse(x, y, mouseButton, pressed)
	--update button
	for i,v in ipairs(self.buttons) do
		v:action(x, y, mouseButton, pressed)
	end
end

function State_Win:key(name)
	if 		name == "Back" then
		transition:go(function () stateIndex = 1 end)
	end
end

function State_Win:button(name,set)
	if name == "Back to main menu" then
		transition:go(function () stateIndex = 1 end)
	end
end
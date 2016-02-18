--[[
	This class holds the in game menu state.
]]--

State_Win = {}

function State_Win:create()
	local new = {}
	setmetatable(new,self)
	self.__index = self

	main_background = love.graphics.newImage("Media/menu_bg.png")
	
	--initialise all buttons for the menu 
	qut = Button:create("back to main menu",{},love.graphics.getHeight()-60)

	new.buttons = {qut}
	--this holds the bindings and name of the keys or buttons
	--					NAME		KEY		BUTTON	PRESSED
	new.bindings =  	{{"Back",	"escape",	10,		false}
						}
	new:reset()
	return new
end

function State_Win:reset()

end

function State_Win:update(dt)
	--update buttons
	for i,v in ipairs(self.buttons) do
        v:update()
	end
end

function State_Win:draw()
	love.graphics.setFont(font)
	--draw background and menu
	love.graphics.setColor(255,255,255)
	love.graphics.draw(main_background,0,0,0,2)
	love.graphics.printf("THANKS FOR PLAYING!",0,200,768,"center")
	love.graphics.printf("brought to you by",0,340,768,"center")
	love.graphics.printf("Hidde\t&\tCasper van Bavel",0,380,768,"center")
	
	--draw buttons
	for i,v in ipairs(self.buttons) do
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
	if name == "back to main menu" then
		transition:go(function () stateIndex = 1 end)
	end
end
--[[
	This class holds the in game menu state.
]]--

State_LevelUp = {}

function State_LevelUp:create()
	local new = {}
	setmetatable(new,self)
	self.__index = self
	
	new.buttons = {}


	new.upgrades = {uHeal,
				uFlail,
				uReach,
				uHealth ,
				uSpeed,
				uDamage}

	--this holds the bindings and name of the keys or buttons
	--					NAME		KEY		BUTTON	PRESSED
	new.bindings =  	{{"Back",	"escape",	10,		false}
						}
	new:reset()
	return new
end

function State_LevelUp:reset()
	self.buttons = {}

	local temp = love.graphics.newScreenshot()
	screenshot = love.graphics.newImage(temp )

	-- choose 3 upgrades
	table.insert(self.buttons, self.upgrades[1]:getButton(150+75))

	local available_upgrades = {}

	for i,v in ipairs(self.upgrades) do
		if(i > 1 and v:available()) then
			table.insert(available_upgrades,v)
		end
	end
	
	if(#available_upgrades == 1) then
		table.insert(self.buttons, available_upgrades[1]:getButton(150+2*75))
	elseif(#available_upgrades > 1) then
		local u1 = math.random(#available_upgrades)
		local u2 = u1
		while(u1 == u2) do
			u2 = math.random(#available_upgrades)
		end

		table.insert(self.buttons, available_upgrades[u1]:getButton(150+2*75))
		table.insert(self.buttons, available_upgrades[u2]:getButton(150+3*75))
	end
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
	for i,v in ipairs(self.upgrades) do
		if(name == v.description) then
			v:nextLevel()
		end
	end

	transition:go(function () stateIndex = 2 end)
end
--[[
	Ai Class.
	types: 	player:	control with the arrow keys
			roam:	slowly roam around the level in a random direction
			appr:	move to the player
--]]

Entity_AI = {}

function Entity_AI:create(active, passive, range)
	local new = {}
	setmetatable(new, self)
	self.__index = self

	new.active  = active
	new.passive = passive
	new.range   = range or -1

	return new
end

function Entity_AI:update(x, y)
	-- set to correct ai
	local current = active
	if range > 0 and ((x-player.bb.x)^2+(y-player.bb.y)^2)^0.5 > range then
			current = passive
	end
	local dx = 0
	local dy = 0
	if 	   current == "player" then
		dx, dy = Entity_AI:player(x, y)
	elseif current == "roam" then
		dx, dy = Entity_AI:roam(x, y)
	elseif current == "appr" then
		dx, dy = Entity_AI:approach(x, y)
	else
		print(current.." is an invalid AI type.")
	end
	return dx, dy
end

function Entity_AI:player(x, y)
	local dx = 0
	local dy = 0
	if     love.keyboard.isDown("a") or love.keyboard.isDown("left")then
		dx = -1
	end
	if     love.keyboard.isDown("d") or love.keyboard.isDown("right") then
		dx = +1
	end
	if     love.keyboard.isDown("w") or love.keyboard.isDown("up") then
		dy = -1
	end
	if     love.keyboard.isDown("s") or love.keyboard.isDown("down") then
		dy = +1
	end
	return dx, dy
end

function Entity_AI:roam(x, y)
	--init roaming
	if self.dir == nil then
		self.dir = love.math.random(0, math.pi)
	end
	--change dir
	self.dir = self.dir + love.math.random(-0.1, 0.1)
	local dx = math.cos(self.dir)
	local dy = math.sin(self.dir)
	return dx, dy
end

function Entity_AI:approach(x, y)
	local dist = ((x-player.bb.x)^2+(y-player.bb.y)^2)^0.5 
	local dx = (x-player.bb.x) / dist
	local dy = (y-player.bb.y) / dist

	return dx, dy
end
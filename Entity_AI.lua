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

function Entity_AI:update(parent)
	-- set to correct ai
	local current = self.active
	if self.range > 0 and ((parent.x-player.x)^2+(parent.y-player.y)^2)^0.5 > self.range then
			current = passive
	end
	if 	   current == "player" then
		Entity_AI:player(parent)
	elseif current == "roam" then
		Entity_AI:roam(parent)
	elseif current == "appr" then
		Entity_AI:approach(parent)
	else
		print(current .." is an invalid AI type.")
	end
end

function Entity_AI:player(parent)
	local dx = 0
	local dy = 0
	if     love.keyboard.isDown("a") or love.keyboard.isDown("left")then
		dx = -1
	end
	if     love.keyboard.isDown("d") or love.keyboard.isDown("right") then
		dx = 1
	end
	if     love.keyboard.isDown("w") or love.keyboard.isDown("up") then
		dy = -1
	end
	if     love.keyboard.isDown("s") or love.keyboard.isDown("down") then
		dy = 1
	end
	parent.xSpeed = dx * parent.speed
	parent.ySpeed = dy * parent.speed
end

function Entity_AI:roam(parent)
	local dx = 0
	local dy = 0
	--init roaming
	if self.dir == nil then
		self.dir = love.math.random(0, math.pi)
	end
	--change dir
	self.dir = self.dir + love.math.random(-0.001, 0.001)
	dx = math.cos(self.dir)
	dy = math.sin(self.dir)
	parent.xSpeed = dx * parent.speed
	parent.ySpeed = dy * parent.speed
end

function Entity_AI:approach(parent)
	local dist = ((parent.x-player.x)^2+(parent.y-player.y)^2)^0.5 
	local dx = (parent.x-player.x) / dist
	local dy = (parent.y-player.y) / dist

	parent.xSpeed = dx * parent.speed
	parent.ySpeed = dy * parent.speed
end
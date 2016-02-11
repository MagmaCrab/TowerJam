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

	new.dir = love.math.random(0, 2*math.pi)
	new.difDir = 0.001
	new.maxTimer = 0.3
	new.timer = math.random()*new.maxTimer
	new.active  = active
	new.passive = passive
	new.range   = range or -1

	return new
end

function Entity_AI:update(parent, dt)
	-- set to correct ai
	local current = self.active
	if self.range > 0 and ((parent.x-player.x)^2+(parent.y-player.y)^2)^0.5 > self.range then
			current = self.passive
	end
	if 	   current == "player" then
		self:player(parent, dt)
	elseif current == "roam" then
		self:roam(parent, dt)
	elseif current == "approach" then
		self:approach(parent, dt)
	elseif current == "explore" then
		self:explore(parent, dt)
	elseif current == "none" then
		parent.xSpeed = 0
		parent.ySpeed = 0
	else
		print("invalid AI type.")
	end
end

function Entity_AI:player(parent, dt)
	local dx = 0
	local dy = 0
	parent.active = false
	if(level.walkStairs) then
		if (level.index%2 == 1) then
			dy = -0.5
			parent.active = true
			parent.lastDir = 4
		else
			dy = 0.5
			parent.active = true
			parent.lastDir = 2
		end
	else
		if     love.keyboard.isDown("a") or love.keyboard.isDown("left")then
			dx = -1
			parent.active = true
			parent.lastDir = 3
		end
		if     love.keyboard.isDown("d") or love.keyboard.isDown("right") then
			dx = 1
			parent.active = true
			parent.lastDir = 1
		end
		if     love.keyboard.isDown("w") or love.keyboard.isDown("up") then
			dy = -1
			parent.active = true
			parent.lastDir = 4
		end
		if     love.keyboard.isDown("s") or love.keyboard.isDown("down") then
			dy = 1
			parent.active = true
			parent.lastDir = 2
		end
	end
	parent.xSpeed = dx * (parent.speed + uSpeed.level*6)
	parent.ySpeed = dy * (parent.speed + uSpeed.level*6)
end

function Entity_AI:roam(parent, dt)
	local dx = 0
	local dy = 0
	--change dir
	self.dir = self.dir + math.random(-self.difDir, self.difDir)
	dx = math.cos(self.dir)
	dy = math.sin(self.dir)
	parent.xSpeed = dx * parent.speed
	parent.ySpeed = dy * parent.speed
end

function Entity_AI:approach(parent, dt)
	local dist = ((parent.x-player.x)^2+(parent.y-player.y)^2)^0.5 
	local dx = (player.x-parent.x) / dist
	local dy = (player.y-parent.y) / dist

	parent.xSpeed = dx * parent.speed
	parent.ySpeed = dy * parent.speed
end

function Entity_AI:explore(parent, dt)
	local dx = 0
	local dy = 0
	self.timer = self.timer - dt
	if self.timer <= 0 then
		self.timer = self.maxTimer
		self.dir = math.random(0,2*math.pi)
	end
	dx = math.cos(self.dir)
	dy = math.sin(self.dir)
	parent.xSpeed = dx * parent.speed
	parent.ySpeed = dy * parent.speed
end
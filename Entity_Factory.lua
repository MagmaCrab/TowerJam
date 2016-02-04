Entity_Factory = {}

function Entity_Factory:create()
	local new = {}
	setmetatable(new, self)
	self.__index = self

	-- load images
	new.playImage  = love.graphics.newImage("Media/placeholder.png")
	new.rockImage  = love.graphics.newImage("Media/placeholder3.png")
	new.slimeImage = love.graphics.newImage("Media/placeholder2.png")
	new.batImage   = love.graphics.newImage("Media/placeholder2.png")
	return new
end

function Entity_Factory:player(x, y)
	local Entity = Entity:create(x, y, self.playImage)
	Entity.ai = Entity_AI:create("player")
	Entity.dynamic = true
	return Entity
end

function Entity_Factory:rock(x, y)
	local Entity = Entity:create(x, y, self.rockImage)
	return Entity
end

function Entity_Factory:slime(x, y)
	local Entity = Entity:create(x, y, self.slimeImage)
	Entity.ai = Entity_AI:create("appr", "roam", 70)
	Entity.enemy   = true
	Entity.dynamic = true
	Entity.speed   = 25
	return Entity
end

function Entity_Factory:bat(x, y)
	local Entity = Entity:create(x, y, self.batImage)
	Entity.enemy   = true
	Entity.dynamic = true
	return Entity
end
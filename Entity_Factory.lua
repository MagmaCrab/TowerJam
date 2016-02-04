Entity_Factory = {}

function Entity_Factory:create()
	local new = {}
	setmetatable(new, self)
	self.__index = self

	-- load images
	new.playImage  = love.graphics.newImage("Media/player.png")
	new.rockImage  = love.graphics.newImage("Media/rock.png")
	new.slimeImage = love.graphics.newImage("Media/slime.png")
	new.batImage   = love.graphics.newImage("Media/placeholder2.png")
	return new
end

function Entity_Factory:player(x, y)
	local Entity = Entity:create(x, y, self.playImage, 10)
	Entity.ai = Entity_AI:create("player")
	Entity.dynamic = true
	return Entity
end

function Entity_Factory:rock(x, y)
	local Entity = Entity:create(x, y, self.rockImage, 1, BoundingBox:create(-8,-6,16,14))
	return Entity
end

function Entity_Factory:slime(x, y)
	local Entity = Entity:create(x, y, self.slimeImage, 5)
	Entity.ai = Entity_AI:create("appr", "roam", 70)
	Entity.enemy   = true
	Entity.dynamic = true
	Entity.speed   = 25
	return Entity
end

function Entity_Factory:bat(x, y)
	local Entity = Entity:create(x, y, self.batImage, 10)
	Entity.enemy   = true
	Entity.dynamic = true
	return Entity
end
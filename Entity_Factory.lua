Entity_Factory = {}

function Entity_Factory:create()
	local new = {}
	setmetatable(new, self)
	self.__index = self

	-- load images
	new.playImage  = love.graphics.newImage("Media/player.png")
	new.rockImage  = love.graphics.newImage("Media/rock.png")
	new.slimeImage = love.graphics.newImage("Media/slime.png")
	new.batImage   = love.graphics.newImage("Media/bat.png")
	return new
end

function Entity_Factory:player(x, y)
	local entity = Entity:create(x, y, self.playImage, 10, BoundingBox:create(-4,0,8,9))
	entity.ai = Entity_AI:create("player")
	entity.dynamic = true
	entity.hp   = 12
	entity.damage = 3
	return entity
end

function Entity_Factory:rock(x, y)
	local entity = Entity:create(x, y, self.rockImage, 1, BoundingBox:create(-8,-6,16,14))
	return entity
end

function Entity_Factory:slime(x, y)
	local entity = Entity:create(x, y, self.slimeImage, 5)
	entity.ai = Entity_AI:create("approach", "roam", 70)
	entity.enemy   = true
	entity.dynamic = true
	entity.speed   = 20
	entity.hp   = 11
	entity.damage = 2
	return entity
end

function Entity_Factory:bat(x, y)
	local entity = Entity:create(x, y, self.batImage, 15)
	entity.ai = Entity_AI:create("explore")
	entity.enemy   = true
	entity.dynamic = true
	entity.flying = true
	entity.speed   = 50
	entity.hp   = 4
	entity.ai.difDir = .02
	return entity
end
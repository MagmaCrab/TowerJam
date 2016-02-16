Entity_Factory = {}

function Entity_Factory:create()
	local new = {}
	setmetatable(new, self)
	self.__index = self

	-- load images
	new.playImage  = love.graphics.newImage("Media/player.png")
	new.rockImage  = love.graphics.newImage("Media/rock.png")
	new.slimeImage = love.graphics.newImage("Media/slime.png")
	new.slimeBigImage = love.graphics.newImage("Media/slimeBig.png")
	new.batImage   = love.graphics.newImage("Media/bat.png")
	new.barImage   = love.graphics.newImage("Media/bar.png")
	new.barTopImage= love.graphics.newImage("Media/barTop.png")
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

function Entity_Factory:bar(x, y)
	local entity = Entity:create(x, y, self.barImage, 1, BoundingBox:create(-8,-6,16,14))
	entity.breakable = true
	entity.noDrop = true
	return entity
end

function Entity_Factory:barTop(x, y)
	local entity = Entity:create(x, y, self.barTopImage, 1, BoundingBox:create(-8,-6,16,14))
	entity.flying = true
	return entity
end

function Entity_Factory:slimeBig(x, y)
	local entity = Entity:create(x, y, self.slimeBigImage, 3)
	entity.ai = Entity_AI:create("approach", "roam", 50)
	entity.bigSlime = true
	entity.noDrop = true
	entity.enemy   = true
	entity.dynamic = true
	entity.speed   = 16
	entity.hp   = 13
	entity.damage = 2
	return entity
end

function Entity_Factory:slime(x, y)
	local entity = Entity:create(x, y, self.slimeImage, 5, BoundingBox:create(-5,-1,10,9))
	entity.ai = Entity_AI:create("approach", "roam", 50)
	entity.enemy   = true
	entity.dynamic = true
	entity.speed   = 20
	entity.hp   = 9
	entity.xp = 2
	entity.damage = 1
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
	entity.xp = 1
	entity.ai.difDir = .02
	return entity
end
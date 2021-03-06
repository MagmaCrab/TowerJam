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
	new.octoImage = love.graphics.newImage("Media/octo.png")
	new.octoTurretImage = love.graphics.newImage("Media/octoTurret.png")
	new.spikeImage = love.graphics.newImage("Media/spike.png")
	new.batImage   = love.graphics.newImage("Media/bat.png")
	new.barImage   = love.graphics.newImage("Media/bar.png")
	new.barTopImage= love.graphics.newImage("Media/barTop.png")
	new.barrelImage   = love.graphics.newImage("Media/barrel.png")
	return new
end

function Entity_Factory:player(x, y)
	local entity = Entity:create(x, y, self.playImage, 10, BoundingBox:create(-5,0,10,9))
	entity.ai = Entity_AI:create("player")
	entity.dynamic = true
	entity.hp   = 12
	entity.xp = 0
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

function Entity_Factory:barrel(x, y)
	local entity = Entity:create(x, y, self.barrelImage, 1, BoundingBox:create(-8,-6,16,14))
	entity.breakable = true
	entity.xp = math.random(4)
	return entity
end

function Entity_Factory:barTop(x, y)
	local entity = Entity:create(x, y, self.barTopImage, 1, BoundingBox:create(-8,-6,16,14))
	entity.flying = true
	return entity
end



function Entity_Factory:octo(x, y)
	local entity = Entity:create(x, y, self.octoImage, 6, BoundingBox:create(-5,-1,10,9))
	entity.ai = Entity_AI:create("run", "roam", 50)
	entity.ai:setShoot(5,1)
	entity.enemy   = true
	entity.dynamic = true
	entity.speed   = 12
	entity.flying = true
	entity.hp   = 12
	entity.xp = 3
	entity.damage = 1
	return entity
end

function Entity_Factory:octoTurret(x, y)
	local entity = Entity:create(x, y, self.octoTurretImage, 1, BoundingBox:create(-5,-1,10,9))
	entity.ai = Entity_AI:create("none")
	entity.ai:setShoot(7,1)
	entity.enemy   = true
	entity.dynamic = true
	entity.speed   = 0
	entity.flying = false
	entity.hp   = 9
	entity.xp = 3
	entity.damage = 1
	return entity
end

function Entity_Factory:spike(x, y)
	local entity = Entity:create(x, y, self.spikeImage, 1, BoundingBox:create(-7,-7,14,14))
	entity.ai = Entity_AI:create("none")
	entity.enemy   = false
	entity.dynamic = true
	entity.speed   = 0
	entity.flying = false
	entity.invincible = true
	entity.damage = 1
	return entity
end

function Entity_Factory:slime(x, y)
	local entity = Entity:create(x, y, self.slimeImage, 5, BoundingBox:create(-5,-1,10,9))
	entity.ai = Entity_AI:create("approach", "roam", 50)
	entity.enemy   = true
	entity.dynamic = true
	entity.speed   = 20
	entity.hp   = 8
	entity.xp = math.random(2)
	entity.damage = 1
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

function Entity_Factory:bat(x, y)
	local entity = Entity:create(x, y, self.batImage, 15)
	entity.ai = Entity_AI:create("explore")
	entity.enemy   = true
	entity.dynamic = true
	entity.flying = true
	entity.speed   = 30
	entity.hp   = 3.5
	entity.xp = math.random(2)
	entity.ai.difDir = .02
	return entity
end
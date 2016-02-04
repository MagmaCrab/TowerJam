Level = {}

entities = {}

function Level:create(index)
	local new = {}
	setmetatable(new, self)
	self.__index = self
	
	entities = {}
	new.index = index
	table.insert(entities, player)
	Level:generate(index)
	new.cleared = false
	return new
end

function Level:update(dt)
-- TODO collision detection

	for i,v in ipairs(entities) do
		v:update(dt)
	end
	if #entities <= 1 and cleared == false then
		cleared = true
--TODO open door
	end
	flail:update(dt)
end

function Level:draw()
	for i,v in ipairs(entities) do
		v:draw()
	end
	flail:draw()
end

function Level:generate(index)
	table.insert(entities, factory:slime(200, 200))
end
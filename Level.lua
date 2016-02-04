Level = {}

function Level:create(index)
	local new = {}
	setmetatable(new, self)
	self.__index = self
	
	new.entities = {}
	new.index = index
	table.insert(new.entities, player)
	Level:generate(index)
	new.cleared = false
	return new
end

function Level:update(dt)
-- TODO collision detection

	for i,v in ipairs(self.entities) do
		v:update(dt)
	end
	if #self.entities <= 1 and cleared == false then
		cleared = true
--TODO open door
	end
	flail:update(dt)
end

function Level:draw()
	for i,v in ipairs(self.entities) do
		v:draw()
	end
	flail:draw()
end

function Level:generate(index)
--TODO generate level
end
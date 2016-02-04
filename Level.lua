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
	entities_ordered = entities

	local function order(obj1,obj2)
		return obj1.y<obj2.y
	end
	table.sort(entities_ordered, order)

	for i,v in ipairs(entities_ordered) do
		v:draw()
	end
	flail:draw()
end

function Level:generate(index)
	local room = room[love.math.random(#room)]
	local locations = {}
	-- add rocks
	for x=0, room:getWidth()-1 do
		for y=0, room:getHeight()-1 do
			local r,g,b = room:getPixel(x, y)
			print(r,g,b)
			if     r == 255 and g == 255 and b == 255 then
				table.insert(entities, factory:rock(x*tileSize+8, y*tileSize+8))
			elseif r == 255 and g == 0   and b == 0 then
				table.insert(locations, {x, y})
			end
		end
	end
	-- add enemies
	local dif = 2 + math.floor(index/3)
	for i=1, dif do
		table.insert(entities, factory:slime(200, 200))
	end
end
Level = {}

entities = {}

function Level:create(index)
	local new = {}
	setmetatable(new, self)
	self.__index = self
	
	flicker_timer = 0
	flicker = 0

	entities = {}
	new.index = index
	table.insert(entities, player)
	new:generate(index)
	new.cleared = false
	items:create()
	-- Create doors
	doorTop = Door:create(176,   0, false)
	doorDown= Door:create(176, 288, true)
	return new
end

function Level:update(dt)
	flicker_timer = flicker_timer+dt
	if(flicker_timer>0.05) then
		flicker_timer = 0
		flicker = 1-flicker
	end

	items:update(dt)

	for i,v in ipairs(entities) do
		v:update(dt)
	end

	flail:update(dt)
	local enemiesCount = 0
	for i,v in ipairs(entities) do
		if v.enemy then
			enemiesCount = enemiesCount + 1
		end
		if(v~=player and v.death) then
			effects:add(v.x,v.y)
			if math.random() < .3 then
				items:add(v.x,v.y)
			end
			table.remove(entities,i)
			playSound(killSound)
		end
	end
	if enemiesCount <= 0 and self.cleared == false then 
		self.cleared = true
		if self.index%2 == 1 then
			doorTop.open = true
		else 
			doorDown.open = true
		end
	end
	effects:update(dt)
end

function Level:draw()
	
	-- Draw doors
	doorTop:draw()
	doorDown:draw()

	entities_ordered = {}
	entities_ordered = shallowcopy(entities)
	table.insert(entities_ordered,flail)
	local function order(obj1,obj2)
		local y1 = obj1.y
		local y2 = obj2.y
		if(not obj1.dynamic) then
			y1=y1-32
		end

		if(not obj2.dynamic) then
			y2=y2-32
		end

		return (y1<y2)
	end
	table.sort(entities_ordered, order)

	for i,v in ipairs(entities_ordered) do
		v:draw()
	end	

	items:draw()
	effects:draw()


	-- Draw doors
	doorTop:drawTop()
	doorDown:drawTop()
end

function Level:generate(index)
	local room = room[love.math.random(#room)]
	local locations = {}
	-- add rocks
	for x=0, room:getWidth()-1 do
		for y=0, room:getHeight()-1 do
			local r,g,b = room:getPixel(x, y)
			if     r == 255 and g == 255 and b == 255 then
				table.insert(entities, factory:rock(x*tileSize+8, y*tileSize+8))
			elseif r == 255 and g == 0   and b == 0 then
				table.insert(locations, {x, y})
			end
		end
	end
	-- add enemies
	local dif = 2 + math.floor((index-.5)/3)
	for i=1, dif do
		loc = locations[love.math.random(#locations)]
		if math.random() < .7 then
			table.insert(entities, factory:slime(loc[1]*tileSize, loc[2]*tileSize))
		else
			table.insert(entities, factory:bat(loc[1]*tileSize, loc[2]*tileSize))
		end
	end
end

function shallowcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

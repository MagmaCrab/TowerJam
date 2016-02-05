items = {}

function items:create()
	items.image = love.graphics.newImage("Media/heart.png")
	for i,v in ipairs(self) do
		table.remove(self,i)
	end
end

function items:add(x,y,type)
	local item = {}
	item.x= x
	item.y=y
	item.type = type or "hp"
	item.timer = 5

	table.insert(items, item)
end

function items:update(dt)
	for i,v in ipairs(self) do
		v.timer = v.timer-dt
		if(v.timer<0) then
			table.remove(self,i)
		end
	end
end

function items:draw()
	for i,v in ipairs(self) do
		if(v.timer>2 or flicker == 1) then
			love.graphics.draw(self.image, math.floor(v.x), math.floor(v.y))
		end
	end
end
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
		local x1,y1,x2,y2 = player:getCorners()

		if(x1-2<v.x and x2+2>v.x and y1-7<v.y and y2+7>v.y) then
			v.timer = 0
			if(player.hp<maxHealth)then
				player.hp = player.hp+1
			end
		end

		v.timer = v.timer-dt
		if(v.timer<0) then
			table.remove(self,i)
		end
	end
end

function items:draw()
	for i,v in ipairs(self) do
		love.graphics.setColor(0, 0, 0, 128)
		love.graphics.ellipse("fill", math.floor(v.x)+0.5,  math.floor(v.y+2)+0.5, 4, 1.5)
		love.graphics.setColor(255, 255, 255, 255)
		if(v.timer>2 or flicker == 1) then
			love.graphics.draw(self.image, math.floor(v.x-3), math.floor(v.y-3-v.timer))
		end
	end
end
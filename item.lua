items = {}

function items:create()
	self.imageHp = love.graphics.newImage("Media/heart.png")
	self.imageXp = {love.graphics.newImage("Media/xp1.png"),
					love.graphics.newImage("Media/xp2.png"),
					love.graphics.newImage("Media/xp3.png"),
					love.graphics.newImage("Media/xp4.png")}
	for i,v in ipairs(self) do
		table.remove(self,i)
	end
end

function items:add(x,y,type,val)
	local item = {}
	item.x=x
	item.y=y
	item.type = type or "hp"
	item.timer = 5
	item.val = val or 1
	table.insert(items, item)
end

function items:update(dt)
	for i,v in ipairs(self) do
		local x1,y1,x2,y2 = player:getCorners()

		if(x1-2<v.x and x2+2>v.x and y1-8<v.y and y2+1>v.y) then
			v.timer = 0
			if(v.type == "hp") then
				if(player.hp<maxHealth)then
					player.hp = player.hp+1
				end
			else
				player.xp = player.xp + v.val
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
			love.graphics.ellipse("fill", math.floor(v.x)+0.5,  math.floor(v.y+2.5)+0.5, 2.5, 1.5)
			love.graphics.setColor(255, 255, 255, 255)
		if v.type == "hp" then
			
			if(v.timer>2 or flicker == 1) then
				love.graphics.draw(self.imageHp, math.floor(v.x-3), math.floor(v.y-3-v.timer))
			end
		else 
			if(v.timer>2 or flicker == 1) then
				love.graphics.draw(self.imageXp[v.val], math.floor(v.x-3), math.floor(v.y-3))
			end
		end
	end
end
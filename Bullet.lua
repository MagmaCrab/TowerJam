bullets = {}

function bullets:create()
	-- load images
	self.image  = love.graphics.newImage("Media/bullet.png")
end

function bullets:update(dt)
	for i,v in ipairs(self) do
		v:update(dt)
		if(v.timer<0) then
			table.remove(self,i)
		end
	end
end

function bullets:draw()
	for i,v in ipairs(self) do
		v:draw()
	end
end

function bullets:add(x,y,speed,damage)
	local t = Bullet:create(x,y,speed,damage)

	table.insert(self,t)
end

Bullet = {}

function Bullet:create(x,y,damage)
	local new = {}
	setmetatable(new, self)
	self.__index = self
	
	new.x = x
	new.y =y
	new.damage = damage

	local dist = ((new.x-player.x)^2+(new.y-player.y)^2)^0.5 
	local dx = (player.x-new.x) / dist
	local dy = (player.y-new.y) / dist

	new.dx = dx*80
	new.dy = dy*80
	new.timer = 5
	return new
end

function Bullet:update(dt)
	self.x = self.x + self.dx*dt
	self.y = self.y + self.dy*dt
	self.timer = self.timer - dt
end

function Bullet:draw()

	love.graphics.draw(bullets.image, math.floor(self.x-4), math.floor(self.y-4))
end
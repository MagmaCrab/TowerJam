Entity = {}

function Entity:create(x, y, link)
	local new = {}
	setmetatable(new, self)
	self.__index = self

	new.x = x
	new.y = y
	new.bb = BoundingBox:create(1,8,14,8)
	new.xSpeed = 0
	new.ySpeed = 0
	new.speed = 50
	new.image = love.graphics.newImage("Media/placeholder.png")

	new.enemy 	= false
	new.dynamic = false

	return new
end

function Entity:update(dt)

-- TODO AI

-- TODO collision checks
	local oldx = self.x
	local oldy = self.y

	self.x= self.x+(self.xSpeed*dt)
	self.y= self.y+(self.ySpeed*dt)


	self:checkCollision(dt,oldx,oldy)
end

function Entity:draw()
	love.graphics.draw(self.image, math.floor(self.x), math.floor(self.y))
	self.bb:draw()
end

function Entity:checkCollision(dt,oldx,oldy)
	--collide with wall
	local x1,y1 = self.x+self.bb.x , self.y+self.bb.y
	local x2,y2 = self.x+self.bb.x+self.bb.w, self.y+self.bb.y+self.bb.h

	if(y1<=24) then
		self.y = oldy
	elseif(y2>=(resy-24)) then
		self.y = oldy
	end

	if(x1<=72) then
		self.x = oldx
	elseif(x2>=(resx-72)) then
		self.x = oldx
	end

	if(x2+y2>=520 )then
		self.x = oldx
		self.y = oldy
	end

	if(x1-y2 <= -136 )then
		self.x = oldx
		self.y = oldy
	end

	if(x2-y1 >= 232 )then
		self.x = oldx
		self.y = oldy
	end

	if(x1+y1<=154 )then
		self.x = oldx
		self.y = oldy
	end


	--collide with other entities
end
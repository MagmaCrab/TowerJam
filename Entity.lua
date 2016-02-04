Entity = {}

function Entity:create(x, y, image, animationSpeed)
	local new = {}
	setmetatable(new, self)
	self.__index = self

	new.x = x
	new.y = y
	new.bb = BoundingBox:create(-7,0,14,8)
	new.xSpeed = 0
	new.ySpeed = 0
	new.speed = 50
	new.ai = nil
	new.animation = Animation:create(image, animationSpeed)
	new.lastDir = 1

	new.enemy 	= false
	new.dynamic = false
	new.active  = true

	return new
end

function Entity:update(dt)
	if self.active then
		self.animation:update(dt)
	end
	if self.ai ~= nil then
		self.ai:update(self)
	end
-- TODO collision checks
	local oldx = self.x
	local oldy = self.y

	self.x= self.x+(self.xSpeed*dt)
	self.y= self.y+(self.ySpeed*dt)

	self:checkCollision(dt,oldx,oldy)
end

function Entity:draw()
	self.animation:draw(math.floor(self.x)-8, math.floor(self.y)-8)
end

function Entity:checkCollision(dt,oldx,oldy)
	--collide with wall
	local x1,y1,x2,y2 = self:getCorners()

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

function Entity:getCorners()
	local x1,y1 = self.x+self.bb.x , self.y+self.bb.y
	local x2,y2 = self.x+self.bb.x+self.bb.w, self.y+self.bb.y+self.bb.h

	return x1,y1,x2,y2
end


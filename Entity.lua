Entity = {}

function Entity:create(x, y, image, animationSpeed, bound)
	local new = {}
	setmetatable(new, self)
	self.__index = self

	new.x = x
	new.y = y
	new.bb = bound or BoundingBox:create(-7,-4,14,14)
	new.xSpeed = 0
	new.ySpeed = 0
	new.speed = 50
	new.ai = nil
	new.hp = 6
	new.xp = 0
	new.damage = 1
	new.damaged = false
	new.animation = Animation:create(image, animationSpeed)
	new.lastDir = 1

	new.death = false

	new.xKnock = 0
	new.yKnock = 0
	new.tKnock = 0

	new.enemy 	= false
	new.noDrop = false
	new.dynamic = false
	new.active  = true
	new.flying  = false

	return new
end
 
function Entity:update(dt)
	if self.active then
		self.animation.dir = self.lastDir
		self.animation:update(dt)
	end
	if self.ai ~= nil then
		self.ai:update(self, dt)
	end
	--movement
	local oldx = self.x
	local oldy = self.y

	-- Give dynamic entities knockback
	if self.dynamic then
		if(self.tKnock > 0) then
			self.tKnock = self.tKnock - dt

			self.xSpeed = self.xSpeed + self.xKnock
			self.ySpeed = self.ySpeed + self.yKnock
		else
			self.tKnock = 0
			self.damaged = false
			if(self.hp<=0) then
				self.death = true
			end
		end
	end

	--check flail for damage
	if (self ~= player and flail.active and (not self.damaged) and  self.dynamic and (not self.invincible)) then
		if(self:checkCollisionOther(flail)) then
			self:knock(player,6)
			self.damaged = true
			self.hp =self.hp - (player.damage + uDamage.level/2)
			playSound(hitSound)
		end
	end

	-- break barrels
	if (self.breakable and flail.active) then
		if(self:checkCollisionOther(flail)) then
			self.death = true
		end
	end

	self.x= self.x+(self.xSpeed*dt)
	self.y= self.y+(self.ySpeed*dt)

	self:checkCollisions(dt,oldx,oldy)
end

function Entity:draw()
	-- Draw shadow for dynamic objects
	love.graphics.setColor(255, 255, 255, 255)
	if self.dynamic then
		love.graphics.setColor(0, 0, 0, 128)
	    love.graphics.ellipse("fill", math.floor(self.x),  math.floor(self.y)+7, 5, 2)
		if(self.damaged)then
		    love.graphics.setColor(255, 0, 0, 255)
		else
			love.graphics.setColor(255, 255, 255, 255)
		end
	end
	if(self.hp>0 or flicker==1)then
		self.animation:draw(math.floor(self.x)-8, math.floor(self.y)-8)
	end
	love.graphics.setColor(255, 255, 255, 255)
end

function Entity:checkCollisions(dt,oldx,oldy)
	--collide with wall
	local x1,y1,x2,y2 = self:getCorners()

	if(not level.walkStairs) then
		if y1 <= 24 then
			self.y = oldy
		elseif y2 >= resy-24 then
			self.y = oldy
		end

		if x1 <= 72 then
			self.x = oldx
		elseif x2 >= resx-72 then
			self.x = oldx
		end
	end
	if x2+y2>=520 then
		self.x = oldx
		self.y = oldy
	end

	if x1-y2 <= -136 then
		self.x = oldx
		self.y = oldy
	end

	if x2-y1 >= 232 then
		self.x = oldx
		self.y = oldy
	end

	if x1+y1 <= 154 then
		self.x = oldx
		self.y = oldy
	end

	--collide with other entities
	for i,v in ipairs(entities) do
		if v~=self and (not self.flying) and self:checkCollisionOther(v) then
			if(v.dynamic) then
				--collisions with dynamic objs resolved with knockback
				self:knock(v)
			elseif (not v.flying) then
				--collsisions with static objs resolved with minimal bbox intersection
				local dx,dy = self:checkCollisionOtherDelta(v)
				if(math.abs(dx)<(math.abs(dy))) then
					self.x = self.x + dx
				else
					self.y = self.y + dy
				end
			end
		end
	end
end

function Entity:getCorners()
	local x1,y1 = self.x+self.bb.x , self.y+self.bb.y
	local x2,y2 = self.x+self.bb.x+self.bb.w, self.y+self.bb.y+self.bb.h

	return x1,y1,x2,y2
end

function Entity:knock(other,speed)
	local s = speed or 1.4
	local dx = self.x-other.x
	local dy = self.y-other.y
	local dist = (dx^2+dy^2)^0.5

	if(dist>0) then

	dx = dx/dist
	dy = dy/dist

	else
		dx = 1
		dy = 0
	end

	self.xKnock = dx*self.speed*s
	self.yKnock = dy*self.speed*s
	
	if(self.hp>0) then
		self.tKnock = 0.20
	end

	if(self ~= player and self.damaged and other.speed == 0) then
		self.hp = self.hp -1
		print("workaround for error")
	end

	if(self == player and other.dynamic and (not self.damaged)) then
		self.damaged = true
		self.hp = self.hp - other.damage
		playSound(damageSound)
	end
end

function Entity:checkCollisionOther(other)
	local sx1,sy1,sx2,sy2 = self:getCorners()
	local ox1,oy1,ox2,oy2 = other:getCorners()

	if  sx1 < ox2 and ox1 < sx2
	and sy1 < oy2 and oy1 < sy2 then
		return true
	end
	return false
end

function Entity:checkCollisionOtherDelta(other)
	local sx1,sy1,sx2,sy2 = self:getCorners()
	local ox1,oy1,ox2,oy2 = other:getCorners()

	local dx,dy = 0,0

	if  sx1 < ox2 and ox1 < sx2
	and sy1 < oy2 and oy1 < sy2 then
		if sx1 <= ox1 then
			dx = ox1 - (sx2 + 0.01)		
		else
			dx = ox2 - (sx1 + 0.01)
		end
		if sy1 <= oy1 then
			dy = oy1 - (sy2 + 0.01)	
		else
			dy = oy2 - (sy1 + 0.01)
		end
	end

	return dx,dy
end



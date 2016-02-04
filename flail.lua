flail = {}


function flail:create()
	self.x = 50
	self.y = 50
	self.active = false
	self.timer = 0
	self.dir = 1
	self.bb = BoundingBox:create(-3,-3,6,6)
	self.image  = love.graphics.newImage("Media/flail.png")
end

function flail:update(dt)
	if(self.timer > 0) then
			self.timer = self.timer - dt
		else
			self.timer = 0
			self.active = false
		end

	local length = 8

	local dx,dy = 0,0

	if(self.active) then

		if(self.dir==1) then
			dx,dy = 1,0
		elseif(self.dir==2) then
			dx,dy = 0,1
		elseif(self.dir==3) then
			dx,dy = -1,0
		elseif(self.dir==4) then
			dx,dy = 0,-1
		end
		dx = player.x + dx*24
		dy = player.y + dy*24

		self.x = self.x*0.98+dx*0.02
		self.y = self.y*0.98+dy*0.02
	else
		dx = player.x - self.x
		dy = player.y - self.y
		if((dx^2+dy^2)^0.5>=length)then
			local angle1 = math.atan2(dy, dx)
			dx = player.x - (math.cos(angle1) * length);
			dy = player.y - (math.sin(angle1) * length);
			self.x = self.x*0.98+dx*0.02
			self.y = self.y*0.98+dy*0.02
		end
	end
end

function flail:attack(dt)
	if(not self.active)then
		self.active = true
		self.timer = 0.3
		self.dir = player.lastDir
	end
end

function flail:draw()
	
	love.graphics.draw(self.image,math.floor(self.x)-4,math.floor(self.y)-4)
end

function flail:getCorners()
	local x1,y1 = self.x+self.bb.x , self.y+self.bb.y
	local x2,y2 = self.x+self.bb.x+self.bb.w, self.y+self.bb.y+self.bb.h

	return x1,y1,x2,y2
end
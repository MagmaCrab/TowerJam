--[[
	Main player class
--]]

Player = {}

function Player:create(x,y)
	local new = {}
	setmetatable(new, self)
	self.__index = self

	new.bb = BoundingBox:create(x+2,y+2,10,10)
	new.acc = 4
	new.friction = 0.95
	new.xSpeed = 0
	new.ySpeed = 0

	return new;
end

function Player:update(dt)
	if     love.keyboard.isDown("a") or love.keyboard.isDown("left")then
		self.xSpeed = self.xSpeed - self.acc
	end
	if     love.keyboard.isDown("d") or love.keyboard.isDown("right") then
		self.xSpeed = self.xSpeed + self.acc
	end
	if     love.keyboard.isDown("w") or love.keyboard.isDown("up") then
		self.ySpeed = self.ySpeed - self.acc
	end
	if     love.keyboard.isDown("s") or love.keyboard.isDown("down") then
		self.ySpeed = self.ySpeed + self.acc
	end
	
	self.xSpeed = self.xSpeed*(1-dt)*self.friction
	self.ySpeed = self.ySpeed*(1-dt)*self.friction
	
	self.bb.x= self.bb.x+(self.xSpeed*dt)
	self.bb.y= self.bb.y+(self.ySpeed*dt)
end

function Player:draw()
	self.bb:draw()
	love.graphics.rectangle("fill", self.bb.x, self.bb.y, 12, 12)
end

--[[
	Main player class
--]]

player = Entity:create(0, 0, image)

--function player:create(x, y, image)
	--player = Entity:create(x, y, image)
--end

function player:update(dt)
	if     love.keyboard.isDown("a") or love.keyboard.isDown("left")then
		self.xSpeed = -self.speed
	end
	if     love.keyboard.isDown("d") or love.keyboard.isDown("right") then
		self.xSpeed = self.speed
	end
	if     love.keyboard.isDown("w") or love.keyboard.isDown("up") then
		self.ySpeed = -self.speed
	end
	if     love.keyboard.isDown("s") or love.keyboard.isDown("down") then
		self.ySpeed = self.speed
	end

-- TODO collision checks

	self.xSpeed = self.xSpeed*(1-dt)*self.friction
	self.ySpeed = self.ySpeed*(1-dt)*self.friction
	
	self.bb.x= self.bb.x+(self.xSpeed*dt)
	self.bb.y= self.bb.y+(self.ySpeed*dt)
end

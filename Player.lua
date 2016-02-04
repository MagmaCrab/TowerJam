--[[
	Main player class
--]]

player = Entity:create(200, 200, image)

--function player:create(x, y, image)
	--player = Entity:create(x, y, image)
--end

function player:update(dt)
	local l = love.keyboard.isDown("a") or love.keyboard.isDown("left")
	local r = love.keyboard.isDown("d") or love.keyboard.isDown("right")
	local u = love.keyboard.isDown("w") or love.keyboard.isDown("up")
	local d = love.keyboard.isDown("s") or love.keyboard.isDown("down")

	if	l then
		self.xSpeed = -self.speed
	elseif     r then
		self.xSpeed = self.speed
	else
		self.xSpeed = 0
	end
	if     u then
		self.ySpeed = -self.speed
	elseif     d then
		self.ySpeed = self.speed
	else
		self.ySpeed = 0
	end

	local oldx = self.x
	local oldy = self.y

	self.x= self.x+(self.xSpeed*dt)
	self.y= self.y+(self.ySpeed*dt)
-- TODO collision checks
	self:checkCollision(dt,oldx,oldy)


end

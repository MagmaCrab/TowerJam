Enemy_Dynamic = {}

function Enemy_Dynamic:create(x, y, link)
	local new = {}
	setmetatable(new, self)
	self.__index = self

	new.bb = BoundingBox:create(x+2,y+2,10,10)
	new.acc = 4
	new.friction = 0.95
	new.xSpeed = 0
	new.ySpeed = 0
	new.image = love.graphics.newImage(link) or love.graphics.newImage("Media/placeholder.png") 

	return new
end

function Enemy_Dynamic:update(dt)
	-- TODO AI --
	self.xSpeed = self.xSpeed*(1-dt)*self.friction
	self.ySpeed = self.ySpeed*(1-dt)*self.friction
	
	self.bb.x= self.bb.x+(self.xSpeed*dt)
	self.bb.y= self.bb.y+(self.ySpeed*dt)
end

function Enemy_Dynamic:draw()
	love.graphics.draw(self.image, self.bb.x, self.bb.y)
end
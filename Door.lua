Door = {}

function Door:create(x, y, lower)
	local new = {}
	setmetatable(new,self)
	self.__index = self

	new.x = x
	new.y = y
	new.lower = lower
	new.active = false
	new.open   = false

	return new
end

function Door:init()
	print("eh")
	self.init = true
	self.topImage = love.graphics.newImage("Media/doorTop.png")
	self.openImage = love.graphics.newImage("Media/doorOpen.png")
	self.closedImage = love.graphics.newImage("Media/doorOpen.png")
end

function Door:open()
	if self.active then
		self.open = true
	end
end

function Door:draw()
	local im = self.closedImage
	if self.open then
		im = self.openImage
	end
	if self.lower then
		love.graphics.draw(im, self.x, self.y)
	else
		love.graphics.draw(im, self.x, self.y, 0, 1, -1)
	end
end

function Door:drawTop()
	if self.lower then
		love.graphics.draw(self.topImage, self.x, self.y)
	else
		love.graphics.draw(self.topImage, self.x, self.y, 0, 1, -1)
	end
end
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
	if new.init == nil then
		new:init()
	end
	return new
end

function Door:init()
	self.init = true
	self.top = love.graphics.newImage("Media/doorTop.png")
	self.open = love.graphics.newImage("Media/doorOpen.png")
	self.closed = love.graphics.newImage("Media/doorOpen.png")
end

function Door:open()
	if self.active then
		self.open = true
	end
end

function Door:draw()
	local im = self.closed
	if self.open then

	end
	if self.lower then
		love.graphics.draw(im, self.x, self.y, 0, 1, -1)
	else
		love.graphics.draw(im, self.x, self.y)
	end
end

function Door:drawTop()
	if self.lower then
		love.graphics.draw(self.top, self.x, self.y)
	else
		love.graphics.draw(self.top, self.x, self.y, 0, 1, -1)
	end
end
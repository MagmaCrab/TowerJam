Animation = {}

function Animation:create(link, speed)
	local new = {}
	setmetatable(new, self)
	self.__index = self

	new.image = love.graphics.newImage(link)
	new.speed = 1/speed
	new.size  = new.image:getHeight()
	new.sheet = {}
	for i=0, (new.image:getWidth()/new.size) - 1 do
		new.sheet[i] = love.graphics.newQuad(i*new.size, 0, new.size, new.size, new.image:getDimensions())
	end
	new.current = 0
	new.timer   = 0
	return new
end

function Animation:draw(x, y, r, sx, sy)
	love.graphics.draw(self.image, self.sheet[self.current], x, y, r, sx, sy)
end

function Animation:update(dt)
	self.timer = self.timer + dt
	if self.timer > self.speed then
		self.timer = 0
		self.current = self.current + 1
		if self.current > #self.sheet then
			self.current = 0
		end
	end
end

function Animation:reset()
	self.current = 0
	self.timer = 0
end
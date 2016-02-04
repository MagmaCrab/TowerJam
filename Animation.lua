Animation = {}

function Animation:create(image, speed)
	local new = {}
	setmetatable(new, self)
	self.__index = self

	new.image = image
	new.dir    = 1	-- 1> 2v 3< 4^
	new.speed = 1/speed
	new.sheet = {}
	for i=1, (new.image:getWidth()/tileSize) do
		for j=1, (new.image:getHeight()/tileSize) do
			print(i,j)
			new.sheet[i] = love.graphics.newQuad((i-1)*tileSize, (j-1)*tileSize, tileSize, tileSize, new.image:getDimensions())
		end
	end
	new.current = 0
	new.timer   = 0
	return new
end

function Animation:draw(x, y)
	love.graphics.draw(self.image, self.sheet[dir][self.current], x, y)
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
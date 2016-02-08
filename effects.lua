effects = {}

function effects:create()
	-- load images
	self.dustImg  = love.graphics.newImage("Media/dust.png")

	self.animation = Animation:create(self.dustImg, 10)
	self.x = 0
	self.y = 0
	self.clouds = {}
	for i=1,500 do
		table.insert(self.clouds, Cloud:create())
	end
end

function effects:update(dt)
	self.animation:update(dt)
	for i,v in ipairs(self.clouds) do
		v:update(dt)
	end
end

function effects:draw()
	--draw effects
	if(not self.animation.ended) then
		self.animation:draw(math.floor(self.x)-8, math.floor(self.y)-8)
	end
	--draw clouds
	love.graphics.setColor(81, 43, 39)
	for i,v in ipairs(self.clouds) do
		v:draw()
	end
end

function effects:add(x,y)
	self.x = x
	self.y = y 
	self.animation:reset()
end

Cloud = {}

function Cloud:create()
	local new = {}
	setmetatable(new, self)
	self.__index = self
	
	new.x = math.random()*(resx+64)-32
	new.y = math.random()*(resy+32)-16
	new.w = 0.85
	return new
end

function Cloud:update(dt)
	self.x = self.x+8*dt
	if(self.x-32>resx)then
		self.x= -32
	end
end

function Cloud:draw()
	local r = ((self.x-resx/2)^2 + (self.y-resy/2)^2)^0.5
	r = r-(resy/2+40)
	
	if(r>0) then
		love.graphics.ellipse("fill", self.x, self.y, r*self.w)
	end
end
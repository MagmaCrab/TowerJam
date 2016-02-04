effects = {}

function effects:create()
	-- load images
	self.dustImg  = love.graphics.newImage("Media/dust.png")

	self.animation = Animation:create(self.dustImg, 10)
	self.x = 0
	self.y = 0
	self.clouds = Cloud:create()
end

function effects:update(dt)
	self.animation:update(dt)
	self.clouds:update(dt)
end

function effects:draw()
	--draw effects
	if(not self.animation.ended) then
		self.animation:draw(math.floor(self.x)-8, math.floor(self.y)-8)
	end
	--draw clouds
	love.graphics.setColor(255, 255, 255)
	self.clouds:draw()
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
	
	new.x = math.random()*resx
	new.y = math.random()*resy
	new.w = 10+math.random()*20
	return new
end

function Cloud:update(dt)
	self.x = self.x+dt
end

function Cloud:draw()
	love.graphics.ellipse("fill", self.x, self.y, self.w*love.math.noise(self.x/50,self.y/50))
end
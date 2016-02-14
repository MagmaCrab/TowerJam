effects = {}

function effects:create()
	-- load images
	self.dustImg  = love.graphics.newImage("Media/dust.png")

	
	self.x = 0
	self.y = 0
	self.clouds = {}
	for i=1,500 do
		table.insert(self.clouds, Cloud:create())
	end
end

function effects:update(dt)
	for i,v in ipairs(self) do
		v.animation:update(dt)
	end
	for i,v in ipairs(self.clouds) do
		v:update(dt)
	end
end

function effects:draw()
	--draw effects
	for i,v in ipairs(self) do
		if(not v.animation.ended) then
			v.animation:draw(math.floor(v.x)-8, math.floor(v.y)-8)
		else 
			table.remove(self,i)
		end
	end
	--draw clouds
	love.graphics.setColor(60, 40, 40)
	for i,v in ipairs(self.clouds) do
		v:draw()
	end
end

function effects:add(x,y)
	local t = {}
	t.x = x
	t.y = y
	t.animation = Animation:create(self.dustImg, 10)
	t.animation:reset()
	table.insert(self,t)
end

Cloud = {}

function Cloud:create()
	local new = {}
	setmetatable(new, self)
	self.__index = self
	
	new.x = math.random()*(resx+64)-32
	new.y = math.random()*(resy+32)-16
	new.w = 0.75
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
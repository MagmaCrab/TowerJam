effects = {}

function effects:create()
	-- load images
	self.dustImg  = love.graphics.newImage("Media/dust.png")

	self.animation = Animation:create(self.dustImg, 10)
	self.x = 0
	self.y = 0
end

function effects:update(dt)
	self.animation:update(dt)
end

function effects:draw()
	--draw effects
	if(not self.animation.ended) then
		self.animation:draw(math.floor(self.x)-8, math.floor(self.y)-8)
	end
	--draw clouds

end

function effects:add(x,y)
	self.x = x
	self.y = y 
	self.animation:reset()
end
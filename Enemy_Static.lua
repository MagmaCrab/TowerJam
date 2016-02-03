Enemy_Static = {}

function Enemy_Static:create(x, y, link)
	local new = {}
	setmetatable(new, self)
	self.__index = self

	new.bb = BoundingBox:create(x+2,y+2,10,10)
	new.image = love.graphics.newImage(link) or love.graphics.newImage("Media/placeholder.png")

	return new 
end

function Enemy_Static:update(dt)

end

function Enemy_Static:draw()
	love.graphics.draw(self.image, self.bb.x, self.bb.y)
end
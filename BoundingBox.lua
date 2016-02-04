--[[
AABB implementation for entity to tile collision detection in 2D
this system only uses rectangular bounding boxes
littleBit is a constant used for collision calculations.
sx and sy are the inserting values
]]--
BoundingBox = {}

littleBit = .2

function BoundingBox:create(x,y,w,h)
	local new = {}
	setmetatable(new,self)
	self.__index = self
	
	new.sx = 0
	new.sy = 0
	new.x = x or 0
	new.y = y or 0
	new.w = w or 0
	new.h = h or 0
	return new
end

function BoundingBox:draw()
	love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
end
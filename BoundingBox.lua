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

-- Checks for collision and runs, if needed, the collision method.
-- Return: if there is an intersection
function BoundingBox:check(x, y, w, h)
	self.sx = 0
	self.sy = 0
	
	if  self.x < x + w and x < self.x + self.w
	and self.y < y + h and y < self.y + self.h then
	    if self.x <= x then
			self.sx = x - (self.x+self.w+littleBit)		
		else
			self.sx = x + w - self.x + littleBit
		end
		if self.y <= y then
			self.sy = y - (self.y+self.h+littleBit)	
		else
			self.sy = y + h - self.y + littleBit	
		end
	    return true
	else 
		return false
	end
end

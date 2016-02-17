bullets = {}

function bullets:create()
	-- load images
end

function bullets:update(dt)
	for i,v in ipairs(self) do
		v:update(dt)
	end
end

function bullets:draw()
	for i,v in ipairs(self) do
		v:draw()
	end
end

function bullets:add(x,y)
	local t = Bullet:create()

	table.insert(self,t)
end

Bullet = {}

function Bullet:create()
	local new = {}
	setmetatable(new, self)
	self.__index = self
	
	return new
end

function Bullet:update(dt)

end

function Bullet:draw()

end
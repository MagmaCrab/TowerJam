Upgrade = {}

function Upgrade:create(description, maxLevel)
	local new = {}
	setmetatable(new, self)
	self.__index = self

	new.description = description
	new.maxLevel = maxLevel
	new.level = 0

	return new
end

function Upgrade:nextLevel()
	if self.maxLevel > self.level then
		self.level = self.level + 1
		print(self.description.." upgraded.")
	end
end

function Upgrade:getButton(height)
	return Button:create(self.description,{},height)
end
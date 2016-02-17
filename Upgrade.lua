Upgrade = {}

function Upgrade:load()
	uHealth = Upgrade:create("Max Health + 2", 5)
	uFlail  = Upgrade:create("Charge Attack", 1) --done
	uReach  = Upgrade:create("Farther Reach", 3)
	uHeal   = Upgrade:create("Fully Heal", 30)
	uSpeed  = Upgrade:create("Move Faster", 3)	--done
	uDamage = Upgrade:create("More Damage", 3)	--done
end

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
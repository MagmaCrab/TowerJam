Upgrade = {}

function Upgrade:load()
	uHealth = Upgrade:create("Max Health + 2", 5)
	uFlail  = Upgrade:create("Charge Attack", 1)
	uReach  = Upgrade:create("Further Reach", 2) 
	uHeal   = Upgrade:create("Fully Heal", 30)
	uSpeed  = Upgrade:create("Move Faster", 3)
	uDamage = Upgrade:create("More Damage", 3)	
	uAttract= Upgrade:create("Item Attraction", 2)
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
		if(self == uHealth) then
			maxHealth = maxHealth + 2
		elseif(self == uHeal) then	
			player.hp = maxHealth
		end

		self.level = self.level + 1
		print(self.description.." upgraded to level " .. self.level)
	end
end

function Upgrade:getButton(height)
	if(self==uHeal) then
		return Button:create(self.description,{},height)
	else
		return Button:create(self.description,{},height,self.level .. "/" .. self.maxLevel)
	end
end


function Upgrade:available()
	return (self.level < self.maxLevel)
end
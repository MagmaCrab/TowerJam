transition = {}

function transition:create()
	self.active = false
	self.timer = 0
	self.subtimer = 0
end

function transition:update(dt)
	local add = 0

	self.subtimer = self.subtimer + dt
	if(self.subtimer >= 0.1) then
		add = 0.09
		self.subtimer = 0
	end	

	--timer calculations
	if(self.active) then
		self.timer = self.timer + add
	else
		self.timer = self.timer - add
	end

	if(self.timer < 0) then
		self.timer = 0
	end

	if(self.timer > 1) then
		self.timer = self.timer - add
		self.active = false
		if(self.action) then
			self.action()
		else
			print("nil function in transition")
		end
	end
end

function transition:draw()
	love.graphics.setColor(0, 0, 0, 255*self.timer)
	love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
end

--action must be a function accessed with '.' NOT ':'
function transition:go(action)
	self.active = true
	self.action = action
end
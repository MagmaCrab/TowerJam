flail = {}


function flail:create()
	self.x = 50
	self.y = 50
end

function flail:update(dt)
	local length = 8

	local dx = player.x - self.x
	local dy = player.y - self.y
	if((dx^2+dy^2)^0.5>=length)then
		local angle1 = math.atan2(dy, dx)
		dx = player.x - (math.cos(angle1) * length);
		dy = player.y - (math.sin(angle1) * length);
		self.x = self.x*0.98+dx*0.02
		self.y = self.y*0.98+dy*0.02
	end
end

function flail:update(dt)
	local length = 8

	local dx = player.x - self.x
	local dy = player.y - self.y
	if((dx^2+dy^2)^0.5>=length)then
		local angle1 = math.atan2(dy, dx)
		dx = player.x - (math.cos(angle1) * length);
		dy = player.y - (math.sin(angle1) * length);
		self.x = self.x*0.98+dx*0.02
		self.y = self.y*0.98+dy*0.02
	end
end

function flail:draw()
	love.graphics.setColor(0, 0, 0)
	love.graphics.ellipse("fill",math.floor(self.x),math.floor(self.y),3)
	love.graphics.setColor(255, 255, 255)
end

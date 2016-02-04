flail = {}


function flail:create()
	self.x = 50
	self.y = 50
end

function flail:update(dt)
	self.x = self.x*0.95+mouseX*0.05
	self.y = self.y*0.95+mouseY*0.05
end

function flail:draw()
	love.graphics.ellipse("fill",math.floor(self.x),math.floor(self.y),5,5)
end

--[[ 
	an simple horizontal button, aligned to the centre of the screen
]]--

Button = {}

function Button:create(name,cycle,y)
	local new = {}
	setmetatable(new,self)
	self.__index = self
	
	new.name = name
	new.y = y
	new.cycle = cycle
	new.hover = false
	new.index = 1

	
	hoverSound = love.sound.newSoundData("media/hover.wav",static)
	clickSound = love.sound.newSoundData("media/click.wav",static)
	return new
end

function Button:draw()
	--draw a white background if the mouse hovers over the button
	if self.hover then
		love.graphics.setColor(255,255,255,50)
		love.graphics.rectangle("fill", 0, self.y-5, love.graphics.getWidth(), font:getHeight()+10)
	end
	love.graphics.setColor(255,255,255)
	
	--don't print the cycle if it's empty'
	if self.cycle[self.index] == nil then
		text = self.name
	else
		text = self.name..": "..self.cycle[self.index]
	end
	love.graphics.printf(text, 0, self.y, love.graphics.getWidth(), "center")
end

function Button:update()
	--check for hovering
	mouseY = InputHandler:getMouseY()
	if mouseY > self.y-5 and mouseY < self.y + font:getHeight()+10  then
		if self.hover == false then
			playSound(hoverSound)
			self.hover = true
		end
	else
		self.hover = false
	end	
end

function Button:action(x, y, button, pressed)
	--check if the button is pressed and callback to the gamestate
	if button == 1 and pressed == true and y > self.y-5 and y < self.y + font:getHeight()+10  then
		playSound(clickSound)
		self.index = self.index + 1
		if self.index > #self.cycle then
			self.index = 1
		end
		states[stateIndex]:button(self.name,self.cycle[self.index])
	end
end

function playSound(sd)
  love.audio.newSource(sd, "static"):play()
end
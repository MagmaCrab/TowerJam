--[[
	Handling input for keyboard  AND controller, at the same time
	suitable only for 1 player games
	the mouse can always be read, even when a controller is selected			
]]--

InputHandler = {}

joysticks  = love.joystick.getJoysticks()

function InputHandler:create()
	local new = {}
	setmetatable(new,self)
	self.__index = self
	
	return new
end

function InputHandler:Refresh()
	joysticks  = love.joystick.getJoysticks()	
end

		--GET INPUT--
function InputHandler:keypressed(key, unicode)
	InputHandler:bindSearch(key,true,true)
end

function InputHandler:keyreleased(key, unicode)
	InputHandler:bindSearch(key,true,false)
end

function InputHandler:joystickpressed(joystick, button)
	InputHandler:bindSearch(button,false,true)
end

function InputHandler:joystickreleased(joystick, button)
	InputHandler:bindSearch(button,false,false)
end

function InputHandler:mousepressed(x, y, button)
	states[stateIndex]:mouse(x, y, button, true)
end

function 	InputHandler:mousereleased(x, y, button)
	states[stateIndex]:mouse(x, y, button, false)
end

function InputHandler:bindSearch(button, keyboard, pressed)
	state  = states[stateIndex]
	for i=0,2,1 do
		for j=1,#state.bindings,1 do
		control = i
		if control>1 then control=1 end
		--look for matching bind
			if button == state.bindings[j][control+2] and pressed == state.bindings[j][4] then
				state:key(state.bindings[j][1])
			end
		end
	end
end

		--GETTERS AND SETTERS--
function InputHandler:getID()
	return(controller)
end

function InputHandler:getInput()
	return(#joysticks)
end

function InputHandler:getMouseX()
	return love.mouse.getX( )
end

function InputHandler:getMouseY()
	return love.mouse.getY()
end

function InputHandler:setInput(controller_)
	controller = controller_
end
--[[
	main game loop  
]]--

require "animation"
require "boundingbox"
require "enemy_dynamic"
require "enemy_static"
require "button"
require "InputHandler"
require "level"
require "player"
require "State_Game"
require "State_Main"
require "State_Menu"

function love.load()
	--fonts loading
	font = love.graphics.newFont("media/runescape_uf.ttf",32)
	love.graphics.setFont(font)
	love.graphics.setDefaultFilter("nearest","nearest",1)
 
	--Gamestates
	stateIndex = 1
	states = {State_Main:create(), State_Game:create(), State_Menu:create()}
	
	print("System succesfully started")
end

function love.update(dt)
	states[stateIndex]:update(dt)
end

function love.draw()
	--refresh
	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
	love.graphics.setColor(255, 255, 255)
	
	states[stateIndex]:draw()	
end

		--callbacks--
function love.keypressed(key, unicode)
	InputHandler:keypressed(key, unicode)
end

function love.keyreleased(key, unicode)
	InputHandler:keyreleased(key, unicode)
end

function love.joystickpressed(joystick, button)
	InputHandler:joystickpressed(joystick, button)
end

function love.joystickreleased(joystick, button)
	InputHandler:joystickreleased(joystick, button)
end

function love.mousepressed(x, y, button)
	InputHandler:mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
	InputHandler:mousereleased(x, y, button)
end

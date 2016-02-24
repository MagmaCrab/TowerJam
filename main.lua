--[[
	main game loop  
]]--


require "Animation"
require "BoundingBox"
require "Door"
require "Entity"
require "Entity_AI"
require "Entity_Factory"
require "Button"
require "InputHandler"
require "Level"
require "State_End"
require "State_Game"
require "State_Main"
require "State_Menu"
require "State_Win"
require "State_LevelUp"
require "Flail"
require "Effects"
require "Item"
require "Transition"
require "Upgrade"
require "Bullet"

debug = false

function love.load()
	--fonts loading
	font = love.graphics.newFont("Media/runescape_uf.ttf",32)
	font_gui = love.graphics.newFont("Media/runescape_uf.ttf",16)
	font_title = love.graphics.newFont("Media/runescape_uf.ttf",64)
	love.graphics.setFont(font)
	love.graphics.setDefaultFilter("nearest","nearest",1)
 	love.math.setRandomSeed( os.time() )

 	menuM = love.sound.newSoundData("Media/menuM.wav")
 	mainM = love.sound.newSoundData("Media/mainM.wav")
 	winM =  love.sound.newSoundData("Media/winM.wav")

 	menuMusic = love.audio.newSource(menuM, "stream")
 	mainMusic = love.audio.newSource(mainM, "stream")
 	winMusic = love.audio.newSource(winM, "stream")


 	music = nil
	--Gamestates
	
	states = {State_Main:create(), State_Game:create(), State_Menu:create(), State_End:create(), State_Win:create(), State_LevelUp:create()}
	if(debug) then
		stateIndex = 2
		states[stateIndex]:reset()
	else
		stateIndex = 1
	end
	transition:create()
	print("System succesfully started")
end

function love.update(dt)
	transition:update(dt)
	states[stateIndex]:update(dt)

	if (stateIndex == 1 or stateIndex == 4) then
		playMusic(menuMusic)
	elseif (stateIndex == 2) then
		playMusic(mainMusic)
	elseif (stateIndex == 5) then
		playMusic(winMusic)
	end
end

function love.draw()
	--refresh
	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
	love.graphics.setColor(255, 255, 255)
	
	states[stateIndex]:draw()	
	transition:draw()
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

function playSound(sd)
  love.audio.newSource(sd, "static"):play()
end

function playMusic(md)
	if(music ~= md) then
		if(music) then
			music:stop()
		end
		if (md) then
			music = md
			music:play()
			music:setLooping(true)
			music:setVolume(0.2)
		end
	end
end

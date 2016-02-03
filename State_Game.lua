--[[
	This class holds the main loop of the game
]]--

State_Game = {}

function State_Game:create()
	local new = {}
	setmetatable(new,self)
	self.__index = self
	--this holds the bindings and name of the keys or buttons
	--						NAME		KEY		BUTTON		TYPE
	State_Game.bindings =  {{"sample",	"",			3,		true},
					   		{"Menu",	"escape",	10,		false}}

	--in game variables
	pixelSize = 2
	resx = love.graphics.getWidth()  / pixelSize
	resy = love.graphics.getHeight() / pixelSize
	canvas = love.graphics.newCanvas(resx, resy)
	background = love.graphics.newImage("media/level.png")

	levelIndex = 0;
	player = Player:create(10, 10)
--TODO intro animation
	level = State_Game:nextLevel()
	return new
end

function State_Game:update(dt)
	level:update(dt)
end

function State_Game:draw()
	love.graphics.setCanvas(canvas)
	love.graphics.clear( )

	love.graphics.draw(background)
	level:draw()

	love.graphics.setCanvas()
	love.graphics.draw(canvas, 0, 0, 0, pixelSize)
end

function State_Game:nextLevel()
	levelIndex = levelIndex + 1
	print("ascending to level "..levelIndex..".")
	return Level:create(levelIndex, player)
end
--input handling--
function State_Game:key(name, set)
	if 		name == "Menu" then
		stateIndex = 3
		states[stateIndex]:reset()
	elseif	name == " " then
		
	end
end

--unused input handling
function State_Game:movement(x,y)

end

function State_Game:mouse(x, y, mouseButton, pressed)

end

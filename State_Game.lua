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
					   		{"Menu",	"escape",	10,		false},
					   		{"Attack",	"space",	10,		true}}

	-- Images
	background 	= love.graphics.newImage("Media/level.png")
	health 		= love.graphics.newImage("Media/health.png")
	damage 		= love.graphics.newImage("Media/damage.png")

	-- Rooms
	room = {love.image.newImageData("Media/rooms/room1.png"),
			love.image.newImageData("Media/rooms/room2.png"),
			love.image.newImageData("Media/rooms/room3.png"),
			love.image.newImageData("Media/rooms/room4.png"),
			love.image.newImageData("Media/rooms/room5.png")}
	-- In game variables
	pixelSize = 2
	tileSize = 16
	resx = love.graphics.getWidth()  / pixelSize
	resy = love.graphics.getHeight() / pixelSize
	canvas = love.graphics.newCanvas(resx, resy)

	levelIndex = 0;
	factory = Entity_Factory:create()
	player = factory:player(194, 32)
	maxHealth = player.hp
	flail:create()
	effects:create()
--TODO intro animation
	level = State_Game:nextLevel()
	return new
end

function State_Game:update(dt)
	mouseX = math.floor(love.mouse.getX( )/pixelSize)
	mouseY = math.floor(love.mouse.getY( )/pixelSize)
	level:update(dt)
end

function State_Game:draw()
	-- Draw level
	love.graphics.setCanvas(canvas)
	love.graphics.clear( )
	love.graphics.draw(background)
	level:draw()
	for i=1, maxHealth do
		if i <= player.hp then
			love.graphics.draw(health, i*5, 276)
		else
			love.graphics.draw(damage, i*5, 276)
		end
	end
	love.graphics.setCanvas()
	love.graphics.draw(canvas, 0, 0, 0, pixelSize)
	love.graphics.setColor(0,0,0)
	-- Draw GUI
	love.graphics.print("Lvl: "..levelIndex, 10, 0)
end

function State_Game:nextLevel()
	levelIndex = levelIndex + 1
	print("ascending to level "..levelIndex..".")
	return Level:create(levelIndex)
end
--input handling--
function State_Game:key(name, set)
	if 		name == "Menu" then
		stateIndex = 3
		states[stateIndex]:reset()
	elseif	name == "Attack" then
		flail:attack()
	end
end

--unused input handling
function State_Game:movement(x,y)

end

function State_Game:mouse(x, y, mouseButton, pressed)

end

--[[
	This class holds the main loop of the game
]]--

State_Game = {}

function State_Game:create()
	local new = {}
	setmetatable(new,self)
	self.__index = self

	-- In game variables
	Door:init()
	pixelSize = 2
	tileSize = 16
	resx = love.graphics.getWidth()  / pixelSize
	resy = love.graphics.getHeight() / pixelSize
	canvas = love.graphics.newCanvas(resx, resy)

	--this holds the bindings and name of the keys or buttons
	--						NAME		KEY		BUTTON		TYPE
	new.bindings =  {--[[{"sample",	"",			3,		true },]]--
					   			{"Menu",	"escape",	10,		false},
					   			{"Attack",	"space",	10,		true },
					   			{"Enter",	"return",	10,		true },
					   			{"Test",	"q",    	10,		true }}

	-- Images
	background 	= love.graphics.newImage("Media/level.png")
	guiImage	= love.graphics.newImage("Media/gui.png")
	healthImage = love.graphics.newImage("Media/health.png")
	damageImage = love.graphics.newImage("Media/damage.png")

	tile 	= {	love.graphics.newImage("Media/tile1.png"),
				love.graphics.newImage("Media/tile2.png"),
				love.graphics.newImage("Media/tile3.png"),
				love.graphics.newImage("Media/tile4.png"),
				love.graphics.newImage("Media/tile5.png"),
				love.graphics.newImage("Media/tile6.png")}
	tileIndex = 1
	for i in ipairs(tile) do
		tile[i]:setWrap("repeat", "repeat")
	end
	tileQuad = love.graphics.newQuad( 0, 0, resy, resy, 16, 16)
	-- Sounds
	flailSound  = love.sound.newSoundData("Media/flail.wav",static)
	hitSound    = love.sound.newSoundData("Media/hit.wav",static)
	damageSound = love.sound.newSoundData("Media/damage.wav",static)
	killSound   = love.sound.newSoundData("Media/kill.wav",static)

	-- Rooms
	room = {love.image.newImageData("Media/rooms/room1.png"),
			love.image.newImageData("Media/rooms/room2.png"),
			love.image.newImageData("Media/rooms/room3.png"),
			love.image.newImageData("Media/rooms/room4.png"),
			love.image.newImageData("Media/rooms/room5.png"),
			love.image.newImageData("Media/rooms/room6.png"),
			love.image.newImageData("Media/rooms/room7.png")}

	

	Upgrade:load()
	bullets:create()
	new:reset()
	return new
end

function State_Game:update(dt)
	mouseX = math.floor(love.mouse.getX( )/pixelSize)
	mouseY = math.floor(love.mouse.getY( )/pixelSize)
	level:update(dt)
	if player.hp <= 0 then
		stateIndex = 4
		states[stateIndex]:reset()
	end

	if player.xp>=xpNext then
		player.xp=xpNext
		upgrade_available = true
	end
end

function State_Game:draw()
	-- Draw level
	love.graphics.setCanvas(canvas)
	love.graphics.clear()
	love.graphics.draw( tile[tileIndex], tileQuad , 64, 0)

	love.graphics.draw(background)
	level:draw()
	love.graphics.draw(guiImage, 1, 250)
	for i=1, maxHealth do
		if i <= player.hp then
			love.graphics.draw(healthImage, i*5+1, 273)
		else
			love.graphics.draw(damageImage, i*5+1, 273)
		end
	end
	if(upgrade_available and flicker == 0) then
		love.graphics.setColor(255,255,255)
	else
		love.graphics.setColor(255,223,66)
	end
	love.graphics.line(6.5, 283.5, 6.5+math.floor((player.xp/xpNext)*64), 283.5)
	love.graphics.setColor(0,0,0)
	-- Draw GUI
	love.graphics.setFont(font_gui)
	love.graphics.print("Lvl: "..30-levelIndex, 4, 254)

	love.graphics.setCanvas()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(canvas, 0, 0, 0, pixelSize)
	
end

function State_Game.nextLevel()
	--level up
	if upgrade_available and (levelIndex ~= 30) then
		player.xp = 0
		xpNext = xpNext + 5 -- 12, 15, 19, 24, ...
		upgrade_available = false
		states[6]:reset()
		transition:go(function () stateIndex = 6 end)
	end

	if(levelIndex == 30) then
		transition:go(function () stateIndex = 5 end)
	else
		levelIndex = levelIndex + 1
		print("ascending to level "..levelIndex..".")
		level = Level:create(levelIndex)
	end
end
--input handling--
function State_Game:key(name, set)
	if 		name == "Menu" then
		stateIndex = 3
		states[stateIndex]:reset()
	elseif	name == "Attack" then
		flail:attack()
	-- DEBUG functions
	elseif	name == "Enter" then
		if (debug) then
			transition:go(self.nextLevel)
		end
	elseif  name == "Test" then
		if (debug) then
			player.xp = player.xp + 5
		end
		--uSpeed:nextLevel()
	end
end

function State_Game:reset()
	if (debug) then
		levelIndex = 0
	else
		levelIndex = -1
	end
	factory = Entity_Factory:create()
	player = factory:player(194, 32)
	maxHealth = player.hp

	xpNext = 12
	upgrade_available = false
	timer_swirl = 0
	flail:create()
	effects:create()
	self:nextLevel()
end

--unused input handling
function State_Game:movement(x,y)

end

function State_Game:mouse(x, y, mouseButton, pressed)

end

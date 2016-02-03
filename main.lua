
mag = 2
resx, resy = love.graphics.getWidth( )/mag, love.graphics.getHeight( )/mag


function love.load()
	love.graphics.setBackgroundColor(100,100,100)
	draw_init()
	background = love.graphics.newImage("media/level.png")
end

function love.update(dt)
	
end

function love.draw()
	love.graphics.setCanvas(canvas)
	love.graphics.clear( )
	--DRAW EVERYTHING
	love.graphics.draw(background)
	--draw canvas magnified
	love.graphics.setCanvas()
	love.graphics.setColor( 255, 255, 255)
 	love.graphics.draw(canvas,0,0, 0, mag)
end

function draw_init()
	canvas = love.graphics.newCanvas( resx, resy)
	canvas:setFilter("nearest", "nearest")
end




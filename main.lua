local Camera = require "lib/hump/camera"
local World = require "lib/world"
local Actor = require "lib/actor"
local world1
local cam = Camera(0, 0)
local actor1

function love.load()
	world1 = World()
	actor1 = Actor{world=world1 }
end

function love.draw()
	local width = love.graphics.getWidth()
	local height = love.graphics.getHeight()
	cam:draw(function()
		world1:draw()
	end)
	love.graphics.setColor(255, 0, 0)
	love.graphics.line(width / 2, 0, width / 2, height)
	love.graphics.line(0, height / 2, width, height / 2)
	love.graphics.setColor(255, 255, 255)
end

function love.update(dt)
	world1:update(dt)
end

function love.mousereleased(x, y, button)
	local width = love.graphics.getWidth()
	local height = love.graphics.getHeight()
	cam:move(x - width / 2, y - height / 2)
end

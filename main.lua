local Camera = require "lib/hump/camera"
local World = require "lib/world"
local Actor = require "lib/actor"
local Human = require "lib/human"
local Planet = require "lib/planet"
local Building = require "lib/building"
local Factory = require "lib/factory"
local Recipie = require "lib/recipie"
local util = require "lib/util"
local world1
local cam = Camera(0, 0)
local actor1
local planet1
local building1

setmetatable(_G, {
	__newindex = function(t, key, value)
		print("Addition to global table:", key, value)
	end })

local foodrecipie = Recipie{
	inputs={barry=1},
	outputs={bar=1},
	period=1
}

function love.load()
	world1 = World()
	planet1 = Planet{world=world1}
	actor1 = Human{world=world1, angle = (math.pi / 2)}
	building1 = Factory{world=world1, posx = 64, posy = 64,
	recipie=foodrecipie, inventory={
		foo = 1,
		bar = 2,
		barry = 5,
	}}
	Human{world=world1, posx=25, posy=5}
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

	love.graphics.print(("planet: (%d, %d)"):format(planet1.physbody:getX(),
                            planet1.physbody:getY()), 0, 0)
end

local thrust = 10

local function pushBody(body, fx, fy)
	local dx, dy
	dx, dy = body:getWorldVector(fx, fy)
	body:applyForce(dx, dy)
end

function love.update(dt)
	world1:update(dt)
	if love.keyboard.isDown("w") then
		pushBody(actor1.physbody, thrust, 0)
	elseif love.keyboard.isDown("s") then
		pushBody(actor1.physbody, -thrust, 0)
	end
	if love.keyboard.isDown("q") then
		pushBody(actor1.physbody, 0, -thrust)
	elseif love.keyboard.isDown("e") then
		pushBody(actor1.physbody, 0, thrust)
	end
	if love.keyboard.isDown("a") then
		actor1.physbody:applyTorque(-thrust)
	elseif love.keyboard.isDown("d") then
		actor1.physbody:applyTorque(thrust)
	end
end

function love.mousereleased(x, y, button)
	local width = love.graphics.getWidth()
	local height = love.graphics.getHeight()
	cam:move(x - width / 2, y - height / 2)
end

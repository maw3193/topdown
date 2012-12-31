local util = require "lib/util"
local Class = require "lib/hump/class"
local Shapes = require "lib/shapes"
local Images = require "lib/images"
local Quads = require "lib/quads"
local Actor = require "lib/actor"

local Planet = Class{name = "Planet", inherits=Actor, function(self, t)
	Actor.construct(self, t)
	-- Fixture
	local shape = Shapes.newring(t.radius or self.radius)
	self.physfix = love.physics.newFixture(self.physbody, shape)
	self.physfix:setFriction(0)
	self:updateBody()

	self.imagepath = t.imagepath
	self.initImage(self, self.imagepath)
end}

-- Defaults
Planet.radius = 256
Planet.mass = 1000000000000
Planet.lindamp = 1
Planet.angdamp = 1
-- Planet.image has no default
-- Planet.xoff has no default
-- Planet.yoff has no default
-- Planet.imgsize has no default
Planet.imagepath = "assets/noise.png"
-- Planet.stencil has no default
Planet.col = {0, 191, 0}

function Planet.initImage(self, imagepath)
	self.image = Images.new(imagepath)
	local w = self.image:getWidth()
	local h = self.image:getHeight()
	self.xoff = w / 2
	self.yoff = h / 2
	self.imgsize = w
	self.stencil = love.graphics.newStencil(function()
		love.graphics.setColor(255, 255, 255)
		love.graphics.circle("fill", 0, 0, self.radius)
	end)
end

function Planet.draw(self)
	local posx, posy = self.physbody:getPosition()
	local angle = self.physbody:getAngle()
	local scale = 2 * self.radius / self.imgsize
	love.graphics.push()
	love.graphics.translate(posx, posy)
	love.graphics.rotate(angle)
	love.graphics.setStencil(self.stencil)
	love.graphics.setColor(self.col)
	love.graphics.draw(self.image, 0, 0, 0, scale, scale,
	                    self.xoff, self.yoff)
	love.graphics.setStencil()
	love.graphics.pop()
end

return Planet

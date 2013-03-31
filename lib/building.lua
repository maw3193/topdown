local Class = require "lib/hump/class"
local Shapes = require "lib/shapes"
local Images = require "lib/images"
local Quads = require "lib/quads"
local Actor = require "lib/actor"

local Building = Class{name="Building", inherits=Actor, function(self, t)
	Actor.construct(self, t)
	self:updateBody()
	-- Fixture
	self.radius = t.radius
	local shape = Shapes.newrectangle(2 * self.radius, 2 * self.radius)
	self.physfix = love.physics.newFixture(self.physbody, shape)

	self.imagepath = t.imagepath
	self:initImage(self.imagepath)
end}

--Defaults
Building.radius = 16
Building.imagepath = "assets/warningbuilding.png"
Building.wallcol = {63, 63, 63}
Building.bodycol = {127, 127, 127}
-- Building.image has no default
-- Building.xoff has no default
-- Building.yoff has no default
Building.bodytype = "static"
-- Methods

function Building.initImage(self, imagepath)
	self.image = Images.new(imagepath)
	self.xoff = -self.image:getWidth() / 2
	self.yoff = -self.image:getHeight() / 2
end

function Building.draw(self)
	local posx, posy = self.physbody:getPosition()
	local angle = self.physbody:getAngle()
	love.graphics.push()
	love.graphics.translate(posx, posy)
	love.graphics.rotate(angle)
	love.graphics.setColor(self.bodycol)
	love.graphics.rectangle("fill", -self.radius, -self.radius,
	                        2 * self.radius, 2 * self.radius)
	love.graphics.setColor(self.wallcol)
	love.graphics.rectangle("line", -self.radius, -self.radius,
	                        2 * self.radius, 2 * self.radius)
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(self.image, self.xoff, self.yoff)
	love.graphics.pop()
end

return Building

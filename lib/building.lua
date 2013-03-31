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
end}

--Defaults
Building.radius = 16
-- Human.imagepath = "assets/human.png"
-- Human.image has no default
-- Human.headquad has no default
-- Human.xoff
-- Human.yoff
Building.bodytype = "static"
-- Methods

function Building.draw(self)
	local posx, posy = self.physbody:getPosition()
	local angle = self.physbody:getAngle()
	love.graphics.push()
	love.graphics.translate(posx, posy)
	love.graphics.rotate(angle)
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("fill", -self.radius, -self.radius,
	                        2 * self.radius, 2 * self.radius)
	love.graphics.pop()
end

return Building

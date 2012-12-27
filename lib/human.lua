local Class = require "lib/hump/class"
local Shapes = require "lib/shapes"
local Actor = require "lib/actor"

local Human = Class{name="Human", inherits=Actor, function(self, t)
	self = Actor(t)
	-- Fixture
	local shape = Shapes.newcircle(t.radius or self.radius)
	self.physfix = love.physics.newFixture(self.physbody, shape)
end}

return Human

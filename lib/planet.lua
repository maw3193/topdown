local Class = require "lib/hump/class"
local Shapes = require "lib/shapes"
local Actor = require "lib/actor"
local Planet = Class{name = "Planet", inherits=Actor, function(self, t)
	Actor.construct(self, t)
	self:updateBody()
	-- Fixture
	local shape = Shapes.newring(t.radius or self.radius)
	self.physfix = love.physics.newFixture(self.physbody, shape)
	print("planet should have mass "..self.mass)
	print("physbody is", self.physbody)
	print("planet has mass "..self.physbody:getMass())
end}

Planet.radius = 256
Planet.mass = 1000000000000
Planet.lindamp = 1
Planet.angdamp = 1

return Planet

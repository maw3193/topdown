local util = require "lib/util"
local Class = require "lib/hump/class"
local Shapes = require "lib/shapes"
local Actor = require "lib/actor"

local Planet = Class{name = "Planet", inherits=Actor, function(self, t)
	Actor.construct(self, t)
	-- Fixture
	local shape = Shapes.newring(t.radius or self.radius)
	self.physfix = love.physics.newFixture(self.physbody, shape)
	self:updateBody()
	util.debug("planet should have mass "..self.mass)
	util.debug("physbody is", self.physbody)
	util.debug("planet has mass "..self.physbody:getMass())
end}

Planet.radius = 256
Planet.mass = 1000000000000
Planet.lindamp = 1
Planet.angdamp = 1

return Planet

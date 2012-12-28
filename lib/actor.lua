local util = require "lib/util"
local Class = require "lib/hump/class"
local Shapes = require "lib/shapes"

local Actor = Class{name="actor", function(self, t)
	-- Initialize physical properties
	assert(t.world, "A world must be defined when constructing actors")
	self.physbody = love.physics.newBody(t.world.physworld, 0, 0, "dynamic")
	self.posx = t.posx
	self.posy = t.posy
	self.angle = t.angle
	self.mass = t.mass
	self.velx = t.velx
	self.vely = t.vely
	self.lindamp = t.lindamp
	self.velang = t.velang
	self.inertia = t.inertia
	self.angdamp = t.angdamp
	self:updateBody()
	t.world:addActor(self)

	self.radius = t.radius
	self.torque = t.torque
end}

-- Defaults

-- Physical properties
-- world is an argument with no default
-- Used by the body
Actor.posx = 0
Actor.posy = 0
Actor.angle = 0
Actor.mass = 1
Actor.velx = 0
Actor.vely = 0
Actor.lindamp = 0
Actor.velang = 0
Actor.inertia = 0
Actor.angdamp = 0

-- Used by the fixture/shape
Actor.radius = 10

Actor.torque = 1

-- Methods
function Actor.draw(self)
	local posx, posy = self.physbody:getPosition()
	local angle = self.physbody:getAngle()
	love.graphics.push()
	love.graphics.translate(posx, posy)
	love.graphics.rotate(angle)
	love.graphics.circle("line", 0, 0, self.radius)
	love.graphics.line(0, 0, self.radius, 0)
	love.graphics.pop()
end

function Actor.update(self, dt)

end

function Actor.updateBody(self)
	util.debug("self.mass = "..self.mass)
	util.debug("physbody is", self.physbody)
	self.physbody:setPosition(self.posx, self.posy)
	self.physbody:setAngle(self.angle)
	self.physbody:setMass(self.mass)
	local velx = self.velx
	local vely = self.vely
	self.physbody:setLinearVelocity(self.velx, self.vely)
	self.physbody:setLinearDamping(self.lindamp)
	self.physbody:setAngularVelocity(self.velang)
	self.physbody:setInertia(self.inertia)
	self.physbody:setAngularDamping(self.angdamp)
end

return Actor

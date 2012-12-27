local Class = require "lib/hump/class"
local Actor = Class{name="actor", function(self, t)
	-- Initialize physical properties
	if not t.world then
		print("Error: A world must be defined when constructing"..
		" actors")
	end
	self.physbody = love.physics.newBody(t.world.physworld,
	                                     t.posx or self.posx,
	                                     t.posy or self.posy,
	                                     "dynamic")
	self.physbody:setAngle(t.angle or self.angle)
	self.physbody:setMass(t.mass or self.mass)
	local velx = t.velx or self.velx
	local vely = t.vely or self.vely
	self.physbody:setLinearVelocity(t.velx or self.velx,
	                                t.vely or self.vely)
	self.physbody:setLinearDamping(t.lindamp or self.lindamp)
	self.physbody:setAngularVelocity(t.velang or self.velang)
	self.physbody:setInertia(t.inertia or self.inertia)
	self.physbody:setAngularDamping(t.angdamp or self.angdamp)
	t.world:addActor(self)

	self.radius = t.radius
	self.torque = t.torque
end}

-- Defaults

-- Physical properties
-- world is an argument with no default
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

Actor.radius = 10
Actor.torque = 1

-- Methods
function Actor.draw(self)
	love.graphics.push()
	love.graphics.translate(self.posx, self.posy)
	love.graphics.rotate(self.angle)
	love.graphics.circle("line", 0, 0, self.radius)
	love.graphics.line(0, 0, self.radius, 0)
	love.graphics.pop()
end

function Actor.update(self, dt)

end

return Actor

local Class = require "lib/hump/class"
local World = Class{name = "World", function(self, t)
	self.physworld = love.physics.newWorld()
	self.actors = {}
end}

function World.draw(self)
	love.graphics.print("World: Hello!", 0, 0)
	for _,v in ipairs(self.actors) do
		v:draw()
	end
end

function World.update(self, dt)
	self.physworld:update(dt)
	for _,v in ipairs(self.actors) do
		v:draw()
	end
end

function World.addActor(self, actor)
	table.insert(self.actors, actor)
end

return World

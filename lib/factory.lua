local Class = require "lib/hump/class"
local Building = require "lib/building"
local Inventory = require "lib/inventory"

local Factory = Class{name="Factory", inherits=Building, function(self, t)
	Building.construct(self, t)
	self.inventory = Inventory{}
	if t.inventory then
		self.inventory:addItems(t.inventory)
	end
end}

-- Factory.inventory has no default

function Factory.draw(self)
	Building.draw(self)

	local posx, posy = self.physbody:getPosition()
	local angle = self.physbody:getAngle()
	love.graphics.push()
	love.graphics.translate(posx, posy)
	love.graphics.rotate(angle)
	love.graphics.print(self.inventory:print(), self.radius,
	                    -self.radius)
	love.graphics.pop()
end

return Factory

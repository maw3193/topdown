local Class = require "lib/hump/class"
local Building = require "lib/building"
local Inventory = require "lib/inventory"

local Factory = Class{name="Factory", inherits=Building, function(self, t)
	Building.construct(self, t)
	self.inventory = Inventory{}
	if t.inventory then
		self.inventory:addItems(t.inventory)
	end
	self.recipie = t.recipie
	self.nexttime = love.timer.getTime() + self.recipie.period
end}

-- Factory.inventory has no default
-- Factory.recipie has no default
Factory.nexttime = 0

function Factory.update(self, dt)
	local t = love.timer.getTime()
	while t >= self.nexttime do
		self.nexttime = self.nexttime + self.recipie.period
		self:cycle()
	end
end

function Factory.cycle(self)
	local canProduce = true
	for input,count in pairs(self.recipie.inputs) do
		if self.inventory[input] < count then
			canProduce = false
			break
		end
	end
	if canProduce then
		for out, count in pairs(self.recipie.outputs) do
			self.inventory[out] = self.inventory[out] + count
		end
		for input, count in pairs(self.recipie.inputs) do
			self.inventory[input] = self.inventory[input] - count
		end
	end
end

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

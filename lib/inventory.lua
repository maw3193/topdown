local Class = require "lib/hump/class"

-- Inventory, stores items where the key is the item, and the value is the
-- quantity.
local Inventory = Class{name="Inventory", function(self, t)
	for k,v in pairs(t) do
		if v ~= 0 then
			self[k] = v
		end
	end
end}

-- Members are the items, name collision is possible, but unlikely.

function Inventory.addItem(self, item, quantity)
	if self[item] then
		self[item] = self[item] + quantity
		if self[item] == 0 then
			self[item] = nil
		end
	else
		self[item] = quantity
	end
end

function Inventory.remItem(self, item, quantity)
	if quantity == nil then
		self[item] = nil
	else
		self:addItem(item, -quantity)
	end
end

function Inventory.print(self)
	local str = ""
	for k,v in pairs(self) do
		str = str..("%s: %d\n"):format(k, v)
	end
	return str
end

return Inventory

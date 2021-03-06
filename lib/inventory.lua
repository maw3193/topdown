local Class = require "lib/hump/class"

-- Inventory, stores items where the key is the item, and the value is the
-- quantity.
local Inventory = Class{name="Inventory", function(self, t)
	local k,v
	for k,v in pairs(t) do
		if v ~= 0 then
			self[k] = v
		end
	end
end}

-- Members are the items, name collision is possible, but unlikely.

function Inventory.addItem(self, item, quantity)
	if self[item] then
		assert (self[item] + quantity >= 0, "Inventory cannot hold a"..
		                                    " negative number of items")
		self[item] = self[item] + quantity
		if self[item] == 0 then
			self[item] = nil
		end
	else
		self[item] = quantity
	end
end

function Inventory.addItems(self, items)
	local k,v
	for k, v in pairs(items) do
		self:addItem(k, v)
	end
end

function Inventory.remItem(self, item, quantity)
	if quantity == nil then
		self[item] = nil
	else
		self:addItem(item, -quantity)
	end
end

function Inventory.remItems(self, items)
	local k,v 
	for k,v in pairs(items) do
		self:remItem(k, v)
	end
end

function Inventory.print(self)
	local str = ""
	local k,v
	for k,v in pairs(self) do
		str = str..("%s: %d\n"):format(k, v)
	end
	return str
end

return Inventory

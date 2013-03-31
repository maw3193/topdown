local Class = require "lib/hump/class"

-- Recipie, states the inputs and outputs of a single production cycle

local Recipie = Class{name="Recipie", function(self, t)
	self.period = t.period
	self.inputs = {}
	self.outputs = {}
	local k,v
	for k,v in pairs(t.inputs) do
		self.inputs[k] = v
	end
	for k,v in pairs(t.outputs) do
		self.outputs[k] = v
	end
end}


Recipie.period = 1
-- Recipie.inputs has no default
-- Recipie.outputs has no default

local Quads = {}

local store = {}
setmetatable(store, {__mode = "v"})

function Quads.setStore(newstore)
	store = newstore
end

function Quads.getStore()
	return store
end

function Quads.new(x, y, w, h, sw, sh)
	local name = ("%d,%d,%d,%d,%d,%d"):format(x, y, w, h, sw, sh)
	if not store[name] then
		store[name] = love.graphics.newQuad(x, y, w, h, sw, sh)
	end
	return store[name]
end

return Quads

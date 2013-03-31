local shapes = {}

local store = {}
setmetatable(store, {__mode = "v"})

function shapes.newcircle(radius)
	local name = "circle"..radius
	if not store[name] then
		store[name] = love.physics.newCircleShape(radius)
	end
	return store[name]
end

function shapes.newring(radius)
	local name = "ring"..radius
	if not store[name] then
		local segmentcount = math.max(10, math.floor(radius))
		local i
		local mult = 2 * math.pi / segmentcount
		local chain_args = {}
		for i=1,segmentcount do 
			local angle = i * mult
			table.insert(chain_args, radius * math.cos(angle))
			table.insert(chain_args, radius * math.sin(angle))
		end
		store[name] = love.physics.newChainShape(true, unpack(chain_args))
	end
	return store[name]
end

return shapes

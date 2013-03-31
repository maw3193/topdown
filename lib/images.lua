local Images = {}

local store = {}
setmetatable(store, {__mode = "v"})

function Images.new(path)
	if not store[path] then
		store[path] = love.graphics.newImage(path)
	end
	return store[path]
end

return Images

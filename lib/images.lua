local Images = {}

local store = {}
setmetatable(store, {__mode = "v"})

function Images.setStore(newstore)
	store = newstore
end

function Images.getStore()
	return store
end

function Images.new(path)
	if not store[path] then
		store[path] = love.graphics.newImage(path)
	end
	return store[path]
end

return Images

local util = {}

function util.debug(...)
	local narg = select('#', ...)
	io.stderr:write(tostring(select(1, ...)))
	for i=2, narg do
		io.stderr:write('\t'..tostring(select(i, ...)))
	end
	io.stderr:write('\n')
end

return util

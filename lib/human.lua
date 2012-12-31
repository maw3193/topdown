local Class = require "lib/hump/class"
local Shapes = require "lib/shapes"
local Images = require "lib/images"
local Quads = require "lib/quads"
local Actor = require "lib/actor"

local Human = Class{name="Human", inherits=Actor, function(self, t)
	Actor.construct(self, t)
	self:updateBody()
	-- Fixture
	local shape = Shapes.newcircle(t.radius or self.radius)
	self.physfix = love.physics.newFixture(self.physbody, shape)

	self.imagepath = t.imagepath
	self:initImage(self.imagepath)
end}

--Defaults
Human.radius = 8
Human.imagepath = "assets/human.png"
-- Human.image has no default
-- Human.headquad has no default
Human.headcol = {237, 237, 24}
-- Human.bodyquad has no default
Human.bodycol = {237, 237, 237}
-- Human.handquad has no default
Human.handcol = {255, 220, 177}
-- Human.weapquad has no default
Human.weapcol = {0, 0, 0}
-- Human.xoff
-- Human.yoff
-- Methods

function Human.initImage(self, imagepath)
	self.image = Images.new(imagepath)
	-- Implicitly, human has a "head", "body", "hand" and "weap" layer
	-- stacked 4-high
	local iw = self.image:getWidth()
	local ih = self.image:getHeight()
	local qw = self.image:getWidth()
	local qh = self.image:getHeight() / 4
	self.headquad = Quads.new(0, qh * 0, qw, qh, iw, ih)
	self.bodyquad = Quads.new(0, qh * 1, qw, qh, iw, ih)
	self.handquad = Quads.new(0, qh * 2, qw, qh, iw, ih)
	self.weapquad = Quads.new(0, qh * 3, qw, qh, iw, ih)
	self.xoff = qw / 2
	self.yoff = qh / 2
end

function Human.draw(self)
	local posx, posy = self.physbody:getPosition()
	local angle = self.physbody:getAngle()
	love.graphics.push()
	love.graphics.translate(posx, posy)
	love.graphics.rotate(angle)
	love.graphics.setColor(255, 255, 255)
	love.graphics.circle("line", 0, 0, self.radius)
	love.graphics.setColor(self.bodycol)
	love.graphics.drawq(self.image, self.bodyquad, 0, 0, 0,
	                    1, 1, self.xoff, self.yoff)
	love.graphics.setColor(self.headcol)
	love.graphics.drawq(self.image, self.headquad, 0, 0, 0,
	                    1, 1, self.xoff, self.yoff)
	love.graphics.setColor(self.handcol)
	love.graphics.drawq(self.image, self.handquad, 0, 0, 0,
	                    1, 1, self.xoff, self.yoff)
	love.graphics.setColor(self.weapcol)
	love.graphics.drawq(self.image, self.weapquad, 0, 0, 0,
	                    1, 1, self.xoff, self.yoff)
	love.graphics.pop()
end

return Human

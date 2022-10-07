local gfx = playdate.graphics
local drawCircleAtPoint = playdate.graphics.drawCircleAtPoint

local cos = math.cos
local sin = math.sin
local sqrt = math.sqrt
local TAU = math.pi * 2
local screenW = 400
local screenH = 240

local max = math.max
local min = math.min
local floor = math.floor

function Graphics()
	local self = {}

	self.color = playdate.graphics.kColorClear

	function self.clear()
		playdate.graphics.clear()
		playdate.graphics.setColor(0) --kColorClear
	end

	function self.setColor(color)
		if color > 0 then
			self.color = 0 --kColorBlack
		elseif color <= 0 then
			self.color = 2 --kColorClear
		else
			self.color = 1 --kColorWhite
		end
		playdate.graphics.setColor(self.color)
	end

	function self.circle(x, y, r)
		drawCircleAtPoint(x, y, r)
	end

	function self.rect(x, y, w, h, ox, oy)
		gfx.drawRect(x + (ox or 0), y + (oy or 0), w, h)
	end

	function self.image(x, y, image, ox, oy)
		image:draw(x + (ox or 0), y + (oy or 0))
	end

	function self.centerCamera(x, y)
		gfx.setDrawOffset(x + (screenW * 0.5), y + (screenH * 0.5))
	end

	function self.blendImages(back, front)
		local backW, backH = back:getSize()
		local frontW, frontH = front:getSize()
		local img = gfx.image.new(
			backW > frontW and backW or frontW,
			backH > frontH and backH or frontH
		)

		gfx.pushContext(img)
		back:draw(0, 0)
		front:draw(0, 0)
		gfx.popContext()

		return img
	end

	function self.getCircleImage(r, filled, pattern)
		local img = gfx.image.new(r * r, r * r)
		gfx.pushContext(img)
		if filled then
			gfx.fillCircleAtPoint(r, r, r)
		else
			gfx.drawCircleAtPoint(r, r, r)
		end
		gfx.popContext()
		return img
	end

	function self.getRectImage(w, h, filled)
		local img = gfx.image.new(w, h)
		gfx.pushContext(img)
		if filled then
			gfx.fillRect(0, 0, w, h)
		else
			gfx.drawRect(0, 0, w, h)
		end
		gfx.popContext()
		return img
	end

	return self
end

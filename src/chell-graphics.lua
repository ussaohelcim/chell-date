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

local gfx = playdate.graphics
local popContext = gfx.popContext
local pushContext = gfx.pushContext
local clear = gfx.clear
local lockFocus = gfx.lockFocus
local unlockFocus = gfx.unlockFocus
local drawPixel = gfx.drawPixel
local setColor = gfx.setColor
local drawText = gfx.drawText
local setImageDrawMode = gfx.setImageDrawMode
local drawRect = gfx.drawRect
local setDrawOffset = gfx.setDrawOffset

local white = gfx.kColorWhite
local black = gfx.kColorBlack
local transparent = gfx.kColorClear

function Graphics()
	local self = {}

	self.color = playdate.graphics.kColorClear

	function self.clear()
		clear()
		setColor(0) --kColorClear
	end

	---Set the draw mode for images and texts.
	-- - "copy", "inverted", "XOR", "NXOR", "whiteTransparent", "blackTransparent", "fillWhite", or "fillBlack".
	---@param mode string
	function self.setDrawMode(mode)
		setImageDrawMode(mode)
	end

	function self.setColor(color)
		if color > 0 then
			self.color = 0 --kColorBlack
		elseif color <= 0 then
			self.color = 2 --kColorClear
		else
			self.color = 1 --kColorWhite
		end
		gfx.setColor(self.color)
	end

	function self.circle(x, y, r)
		drawCircleAtPoint(x, y, r)
	end

	function self.fillCircle(x, y, r)
		gfx.fillCircleAtPoint(x, y, r)
	end

	function self.arc()
		-- gfx.drawArc()
	end

	function self.rect(x, y, w, h, ox, oy)
		drawRect(x + (ox or 0), y + (oy or 0), w, h)
	end

	function self.fillRect(x, y, w, h, ox, oy)
		gfx.fillRect(x + (ox or 0), y + (oy or 0), w, h)
	end

	function self.image(image, x, y, ox, oy)
		image:draw(x + (ox or 0), y + (oy or 0))
	end

	function self.centerCamera(x, y)
		setDrawOffset(x + (screenW * 0.5), y + (screenH * 0.5))
	end

	function self.blendImages(back, front)
		local backW, backH = back:getSize()
		local frontW, frontH = front:getSize()
		local img = gfx.image.new(
			backW > frontW and backW or frontW,
			backH > frontH and backH or frontH
		)
		lockFocus(img)
		back:draw(0, 0)
		front:draw(0, 0)
		unlockFocus()
		return img
	end

	function self.getCircleImage(r, filled, pattern)
		local img = gfx.image.new(r * r, r * r)
		lockFocus(img)
		if filled then
			gfx.fillCircleAtPoint(r, r, r)
		else
			drawCircleAtPoint(r, r, r)
		end
		unlockFocus()
		return img
	end

	function self.getRectImage(w, h, filled, pattern)
		local img = gfx.image.new(w, h)
		gfx.lockFocus(img)
		if filled then
			gfx.fillRect(0, 0, w, h)
		else
			gfx.drawRect(0, 0, w, h)
		end
		gfx.unlockFocus()
		return img
	end

	return self
end

function Image(path, ox, oy)
	local s = {}

	s.img = gfx.image.new(path)
	s.originX = ox or 0
	s.originY = oy or 0

	function s.draw(x, y)
		s.img:draw(x + s.originX, y + s.originY)
	end

	return s
end

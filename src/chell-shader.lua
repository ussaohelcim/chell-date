-- gfx.kColorClear --2
-- gfx.kColorBlack --0
-- gfx.kColorWhite --1

local gfx = playdate.graphics
local popContext = gfx.popContext
local pushContext = gfx.pushContext

--- 0 = white
--- 1 = black
--- -1 = clear
local function playdateColorToChellColor(color)
	if color == 0 then --kColorBlack
		return 1
	elseif color <= 0 then --kColorClear
		return -1
	end
	return 0 --kColorWhite
end

function ShaderUtils()
	local self = {}

	---Returns the pixel color.
	-- 0 = white
	-- 1 = black
	-- -1 = clear
	---@return integer
	function self.texture(img, x, y)
		return playdateColorToChellColor(
			img:sample(x, y)
		)
	end

	return self
end

function FragmentShader(width, height)
	local self = {}
	self.w = width
	self.h = height

	---Called for every pixel. MUST return 0,1.
	--  - 0 = white
	--  - 1 = black
	--  - -1 = clear
	---@param x number x position inside [0,width)
	---@param y number y position inside [0,height)
	---@return number
	function self.frag(x, y) end

	---Returns a playdate image of this fragment shader
	function self.toImage()
		local img = gfx.image.new(self.w, self.h)

		gfx.lockFocus(img)

		gfx.clear(gfx.kColorClear)

		local a = 0

		for y = 1, self.h - 1, 1 do
			for x = 1, self.w - 1, 1 do
				a = a + 1
				if self.frag(x, y) == 1 then
					gfx.setColor(gfx.kColorBlack)
					gfx.drawPixel(x, y)
				elseif self.frag(x, y) == 0 then
					gfx.setColor(gfx.kColorWhite)
					gfx.drawPixel(x, y)
				end
			end
		end

		gfx.unlockFocus()

		return img

	end

	return self
end

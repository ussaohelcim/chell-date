import "CoreLibs/graphics"

local cos = math.cos
local sin = math.sin
local sqrt = math.sqrt
local TAU = math.pi * 2
local screenW = 400
local screenH = 240

local max = math.max
local min = math.min
local floor = math.floor

function Math()
	--math library
	local self = {}

	---Returns x clamped to the range [a,b]
	---@param x number
	---@param a number
	---@param b number
	---@return number
	function self.clamp(x, a, b)
		return max(a, min(b, x));
	end

	---Returns the scalar dot product of two same-typed vectors 1 and 2.  `math.sin(dot(x1, y1, x2, y2))`
	---@param x1 number
	---@param y1 number
	---@param x2 number
	---@param y2 number
	---@return number
	function self.dot(x1, y1, x2, y2)
		return x1 * x2 + y1 * y2
	end

	---Returns the Euclidean distance from a first point pt1 to a second point pt2.
	---@param x1 number
	---@param y1 number
	---@param x2 number
	---@param y2 number
	---@return number
	function self.distance(x1, y1, x2, y2)
		local x, y = x1 - x2, y1 - y2
		return sqrt(x * x + y * y)
	end

	---Returns x saturated to the range [0,1] as follows:
	-- 1) Returns 0 if x is less than 0; else
	-- 2) Returns 1 if x is greater than 1; else
	-- 3) Returns x otherwise.
	---@param x number
	---@return integer
	function self.saturate(x)
		return max(0, min(1, x))
	end

	---Returns the Euclidean length of a vector.
	function self.length(x, y)
		return sqrt(x * x + y * y)
	end

	-- local saturate = self.saturate

	---Interpolates smoothly from 0 to 1 based on x compared to a and b.
	-- 1) Returns 0 if x < a < b or x > a > b
	-- 1) Returns 1 if x < b < a or x > b > a
	-- 3) Returns a value in the range [0,1] for the domain [a,b].
	---@param a number
	---@param b number
	---@param x number
	function self.smoothStep(a, b, x)
		local t = self.saturate((x - a) / (b - a));
		return t * t * (3.0 - (2.0 * t));
	end

	---Returns the fractional portion of a scalar or each vector component.
	---@param v number
	---@return integer
	function self.fract(v)
		return v - floor(v)
	end

	---Any value under the limit will return 0.0 while everything above the limit will return 1
	---@param a any the limit or threshold
	---@param x any the value we want to check or pass
	---@return integer
	function self.step(a, x)
		return a >= x and 1 or 0
	end

	---Returns the linear interpolation of a and b based on weight t. (!can be extrapolated!)
	-- 1) a and b are either both scalars or both vectors of the same length. The weight t may be a scalar or a vector of the same length as a and b. t can be any value (so is not restricted to be between zero and one); if t has values outside the [0,1] range, it actually extrapolates.
	---@param a number
	---@param b number
	---@param t number
	---@return number
	function self.lerp(a, b, t)
		return a + t * (b - a);
	end

	return self
end

-- function Collision()
-- 	--collision library
-- 	local self = {}

-- 	function self.circles(x1, y1, r1, x2, y2, r2)

-- 	end

-- 	function self.lines()

-- 	end

-- 	function self.lineCircle()

-- 	end

-- 	function self.rects()

-- 	end

-- 	function self.rectCircle()

-- 	end

-- 	function self.rectPoint()

-- 	end

-- 	function self.rectLine()

-- 	end

-- 	return self
-- end

-- function Robot()
-- 	--finite state machine library
-- end

-- function ScriptedText(txt)
-- 	--clone do adn Text
-- 	local self = {}

-- 	function self.draw()

-- 	end

-- 	function self.updateAndDraw(dt, cx, cy)

-- 	end

-- 	return self
-- end

-- function SceneManager()
-- 	--scene library
-- 	local self = {}

-- 	return self
-- end


local timeDT = playdate.getCurrentTimeMilliseconds
local _lastDT = timeDT()
local getButtonState = playdate.getButtonState

function Chell()
	local self = {}
	local input = {}

	_lastDT = timeDT()

	local function _Update()
		local now = timeDT()
		local dt = now - _lastDT
		_lastDT = now

		local current, pressed, released = getButtonState()


		self.update(dt * 0.001)
		self.draw(dt * 0.001)
	end

	playdate.update = _Update

	---Draw callback, called every frame
	---@param dt number time since last engine update in seconds
	function self.draw(dt) end

	---Update callback, called every frame
	---@param dt number time since last engine update in seconds
	function self.update(dt) end

	---Input callback, called every frame
	---@param btn any
	function self.input(btn) end

	return self
end

import "CoreLibs/graphics"

local screenW = 400
local screenH = 240

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

function Scene()
	local self = {}
	_lastDT = timeDT()

	local function _Update()
		local now = timeDT()
		local dt = now - _lastDT
		_lastDT = now

		self.update(dt * 0.001)
		self.draw(dt * 0.001)
	end

	---Start this scene. This replace the playdate.update to this scene.
	function self.start()
		playdate.update = _Update
	end

	---Draw callback, called every frame
	---@param dt number time since last engine update in seconds
	function self.draw(dt) end

	---Update callback, called every frame
	---@param dt number time since last engine update in seconds
	function self.update(dt) end

	return self
end

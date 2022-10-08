local getButtonState = playdate.getButtonState

function Input()
	local self = {}
	self.actions = {}
	local input = 0
	local current, pressed, released = 0, 0, 0

	---Bind keys to an action.
	---  Actions can be any data, such a number or a string.
	---Example:
	---
	---`input.bind({ playdate.kButtonA, playdate.kButtonB }, "shoot")`
	---@param keys table a list of keys
	---@param action any some data
	function self.bind(keys, action)
		local n = 0

		for i = 1, #keys, 1 do
			local k = keys[i]
			n = n + k
		end

		self.actions[action] = n
	end

	function self.update()
		current, pressed, released = getButtonState()
	end

	function self.isHolding(action)
		input = current - pressed - released
		return input == self.actions[action]
	end

	-- function self.justPressed(action)
	-- 	input = pressed - released
	-- 	return input == self.actions[action]
	-- end

	return self
end

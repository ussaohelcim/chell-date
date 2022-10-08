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

	---Binds this binds to actions.
	---Example:
	---
	---```lua
	-- i.bind2({
	-- 		{
	-- 			keys = { playdate.kButtonA, playdate.kButtonB },action = "shoot"
	-- 		},
	-- 		{
	-- 			keys = { playdate.kButtonA },	action = "a"
	-- 		}
	-- 	})
	---```
	---@param binds any
	function self.bind2(binds)
		for i = 1, #binds, 1 do
			local b = binds[i]
			print(b.action)
			print(#b.keys)
			local n = 0
			for j = 1, #b.keys, 1 do
				local k = b.keys[j]
				n = n + k
			end

			self.actions[b.action] = n
		end
	end

	function self.update()
		current, pressed, released = getButtonState()
	end

	function self.isHolding(action)
		input = current - pressed - released
		return input == self.actions[action]
	end

	function self.justPressed(action)
		input = pressed
		return input == self.actions[action]
	end

	function self.justReleased(action)
		input = released
		return input == self.actions[action]
	end

	return self
end

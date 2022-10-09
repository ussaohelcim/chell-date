-- function Animator()
-- 	local self = {}
-- 	self.animations = {}

-- 	function self.addAnimation(id, animation)
-- 		self.animations[id] = animation
-- 	end

-- 	function self.updateAndDraw()
-- 		for i = 1, #self.animations, 1 do
-- 			local a = self.animations[i]
-- 		end
-- 	end

-- 	return self
-- end

---Returns an animation table
---@param frameList Frame list of frames (Frame())
---@return table
function Animation(frameList)
	local self = {}
	self.cursorPosition = 1
	self.size = #frameList
	self.image = frameList[self.cursorPosition].image
	self.timeToNext = frameList[self.cursorPosition].duration

	function self.update(dt)
		self.timeToNext = self.timeToNext - dt

		if self.timeToNext <= 0 then
			self.cursorPosition = self.cursorPosition + 1

			if self.cursorPosition > self.size then
				self.cursorPosition = 1
			end

			self.image = frameList[self.cursorPosition].image
			self.timeToNext = frameList[self.cursorPosition].duration
		end
	end

	function self.draw(x, y)
		self.image:draw(x, y)
	end

	return self
end

function Frame(imgPath, duration)
	local self = {}

	self.image = playdate.graphics.image.new(imgPath)
	self.duration = duration

	return self
end

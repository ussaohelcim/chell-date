import "CoreLibs/ui"
import "CoreLibs/timer"

local updateTimers = playdate.timer.updateTimers
local buttonJustPressed = playdate.buttonJustPressed

local btn_up = playdate.kButtonUp
local btn_down = playdate.kButtonDown
local btn_left = playdate.kButtonLeft
local btn_right = playdate.kButtonRight
local btn_a = playdate.kButtonA
local btn_b = playdate.kButtonB

-- local btn_down = playdate.kButtonDown

local function listview(list, elementWidth, elementHeight, loop)
	local s = {}

	s.loop = loop or false --TODO not loop from 1 to last
	s.enabled = true
	s.size = #list
	s.list = list
	s.cursor = 1
	s.gridview = playdate.ui.gridview.new(elementWidth, elementHeight)

	function s.drawCellCallback(section, row, column, selected, x, y, width, height) end

	return s
end

---comment
---@param list any
---@param elementWidth any
---@param elementHeight any
---@return table
function V_ListView(list, elementWidth, elementHeight)
	local s = listview(list, elementWidth, elementHeight)
	-- s.enabled = true
	-- s.size = #list
	-- s.cursor = 1
	-- s.gridview = playdate.ui.gridview.new(elementWidth, elementHeight)

	s.gridview:setNumberOfRows(#list)

	---comment
	---@param section any
	---@param row number
	---@param column number
	---@param selected boolean
	---@param x number
	---@param y number
	---@param width number
	---@param height number
	function s.drawCellCallback(section, row, column, selected, x, y, width, height) end

	function s.gridview:drawCell(section, row, column, selected, x, y, width, height)
		s.drawCellCallback(section, row, column, selected, x, y, width, height)
	end

	function s.draw(x, y, w, h)
		if s.enabled then
			s.gridview:drawInRect(x, y, w, h)
		end
		-- if self.gridview.needsDisplay then
		-- end
	end

	function s.update()
		if buttonJustPressed(btn_up) then
			s.gridview:selectPreviousRow(true)
			s.cursor = s.cursor - 1

			if s.cursor <= 0 then
				s.cursor = s.size
			end
		elseif buttonJustPressed(btn_down) then
			s.cursor = s.cursor + 1
			s.gridview:selectNextRow(true)

			if s.cursor > s.size then
				s.cursor = 1
			end
		end

		updateTimers()
	end

	return s
end

---A vertical list view with actions support
---@param list table list of tables. To use actions: {isAction = true, action = function(element) end} (element must be this object)
---@return table
function V_ActionList(list, elementWidth, elementHeight)
	local s = V_ListView(list, elementWidth, elementHeight)

	function s.update()
		if buttonJustPressed(btn_up) then
			s.gridview:selectPreviousRow(true)
			s.cursor = s.cursor - 1

			if s.cursor <= 0 then
				s.cursor = s.size
			end
		elseif buttonJustPressed(btn_down) then
			s.cursor = s.size + 1
			s.gridview:selectNextRow(true)

			if s.cursor > s.size then
				s.cursor = 1
			end
		elseif buttonJustPressed(btn_a) then
			if list[s.cursor].action then
				list[s.cursor].action(s, s.cursor)
			end
		end

		updateTimers()
	end

	return s
end

---A horizontal list view with actions support
---@param list table list of tables. To use actions: { action = function(element,index) end} (element will be this list, index is the index of the object with action in this list)
---@return table
function H_ActionList(list, elementWidth, elementHeight)
	local s = listview(list, elementWidth, elementHeight)

	-- s.enabled = true
	-- s.size = #list
	-- s.cursor = 1
	-- s.gridview = playdate.ui.gridview.new(elementWidth, elementHeight)

	s.gridview:setNumberOfRows(1)
	s.gridview:setNumberOfColumns(#list)

	---comment
	---@param section any
	---@param row number
	---@param column number
	---@param selected boolean
	---@param x number
	---@param y number
	---@param width number
	---@param height number
	function s.drawCellCallback(section, row, column, selected, x, y, width, height) end

	function s.gridview:drawCell(section, row, column, selected, x, y, width, height)
		s.drawCellCallback(section, row, column, selected, x, y, width, height)
	end

	function s.draw(x, y, w, h)
		if s.enabled then
			s.gridview:drawInRect(x, y, w, h)
		end
		-- if self.gridview.needsDisplay then
		-- end
	end

	function s.update()
		if s.enabled then
			if buttonJustPressed(btn_left) then
				s.gridview:selectPreviousColumn(true)
				s.cursor = s.cursor - 1

				if s.cursor <= 0 then
					s.cursor = s.size
				end

			elseif buttonJustPressed(btn_right) then
				s.cursor = s.cursor + 1
				s.gridview:selectNextColumn(true)

				if s.cursor > s.size then
					s.cursor = 1
				end
			elseif buttonJustPressed(btn_a) then
				if list[s.cursor].action then
					list[s.cursor].action(s, s.cursor)
				end
			end

			updateTimers()
		end
	end

	return s
end

function GridActionList()
	local s = {}
	--TODO create a list of vertical lists that
	return s
end

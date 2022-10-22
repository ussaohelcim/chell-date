function Component()
	local s = {}
	s.__name = "component"
	return s
end

function GameObject()
	local s = {}

	---Mix this object with component
	---@param component table Needs a '__name' key.
	function s.addComponent(component)
		s[component.__name] = component
	end

	---Mix this object with those components
	---@param ... unknown Each one needs a '__name' key.
	function s.addComponents(...)
		for i = 1, #arg, 1 do
			local component = arg[i]
			s[component.__name] = component
		end
	end

	function s.getComponent(name)
		return s[name]
	end

	return s
end

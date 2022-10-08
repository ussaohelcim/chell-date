# chell-date
Game framework for the playdate console.

## How to use

- `import "moduleName-date"`

## Design

The design goal of this framework is to use static functions to handle everything. Something like raylib, love2d/lovr and the playdate api.  

## chell-date callbacks

- update(dt)
	- second callback to be called every frame
- draw(dt)
	- last callback to be called every frame

## Examples

```lua
---chell-date
import "chell-date"

local game = Chell()

--set draw callback
game.draw = function(dt)
	playdate.graphics.clear()
	playdate.graphics.drawCircleAtPoint(x,y,r)
end

game.update = function(dt)
	if playdate.buttonJustPressed("a") then
		jump()
	end
end
```
```lua
---chell-input
import "chell-input"
local i = Input()

i.bind(
	{ playdate.kButtonA, playdate.kButtonB }, "special"
)

playdate.update = function()
	i.update()
	
	if i.isHolding("special") then
		special()
	end
end
```
```lua
---chell-graphics
import "chell-graphics"
local gfx = Graphics()
local img = playadate.graphics.image.new("path")

playdate.update = function()
	gfx.image(img, x, y,)
end
```
```lua
---chell-shader
import "chell-shader"
local shader = FragmentShader(100, 100)
local s = ShaderUtils()
local midX, midY = 50, 50

shader.frag = function(x, y)
	local d = m.distance(x, y, midX, midY)
	local r = d > 50 and 1 or -1
	return r
end

local img = shader.toImage()

playdate.update = function()
	img:draw(x,y)
end

```

## About contributing and using

This is a framework made **by me to me**. This means that **i'll probably not add a feature if you ask one**, but feel free to use and contributing with the code.  

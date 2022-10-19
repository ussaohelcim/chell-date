# chell-date
Game framework for the playdate console.

## How to use

- `import "moduleName-date"`

## Design

The design goal of this framework is to use static functions to handle everything. Something like raylib, love2d/lovr and the playdate api.  

## chell-date callbacks

- update(dt)
	- first callback to be called every frame
- draw(dt)
	- last callback to be called every frame

## Examples

```lua
---chell-date
import "chell-date"

local game1 = Scene()
local game2 = Scene()

game1.update = function(dt)
	if playdate.buttonJustPressed('a') then
		game2.start()
	end
end

game2.update = function(dt)
	if playdate.buttonJustPressed('a') then
		game1.start()
	end
end

game2.draw = function(dt)
	playdate.graphics.drawText("scene1", 0, 0)
end

game1.draw = function(dt)
	playdate.graphics.drawText("scene1", 0, 0)
end

game1.start()
```
```lua
---chell-animation
import "chell-animation"
local anim = Animation(
	{
		Frame("frame1", 0.2),
		Frame("frame2", 0.2),
		Frame("frame3", 0.2),
	}
)

playdate.update = function (dt)
	anim.update(dt)
	anim.image:draw()
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

```lua
---chell-math
import "chell-math"

local m = Math()
local c = Collision()
local ball = { 0, 0, 10 }
local ball2 = { 15, 5, 10 }

if c.checkColissionCircleRect(
	ball[1], ball[2], ball[3],
	ball2[1], ball2[2], ball2[3]
) then
	print("colliding")
end

print(m.distance(
		ball[1], ball[2],
		ball2[1], ball2[2],
	))
```

## About contributing and using

This is a framework made **by me to me**. This means that **i'll probably not add a feature if you ask one**, but feel free to use and contributing with the code.  

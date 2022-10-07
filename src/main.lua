import "chell-date"
import "chell-graphics"
import "chell-shader"
import "chell-party"

local game = Chell()
local gfx = Graphics()
local m = Math()
local cam = { x = 0, y = 0, r = 100 }
local a = 0
local shader = FragmentShader(100, 100)
local s = ShaderUtils()
local midX, midY = 50, 50

shader.frag = function(x, y)
	local d = m.distance(x, y, midX, midY)
	local r = d > 50 and 1 or -1
	return r
end

local img = shader.toImage()
local t = gfx.getCircleImage(100, false)

shader.frag = function(x, y)
	local d = m.distance(x, y, midX, midY)
	local r = d < 20 and 1 or -1
	return r
end

local img2 = shader.toImage()
img = gfx.blendImages(img, img2)
-- print(s.texture(img, 0, 0))

local circles = PARTY(gfx.getCircleImage(100, true))
local rects = PARTY(gfx.getRectImage(10, 10, false))
local party = PartySystem({ circles, rects })

game.draw = function(dt)
	gfx.clear()
	gfx.centerCamera(cam.x, cam.y)
	gfx.circle(0, 0, 100)
	gfx.rect(0, 0, -100, 10)
	t:draw(0, 0)
	party.updateAndDraw(dt)
	gfx.image(0, 0, img)
end

game.update = function(dt)
	cam.x = math.cos(a) * 100
	a = a + 1 * dt
	if playdate.buttonJustPressed("a") then
		circles.createParticle(math.random(0, 400), math.random(0, 240), 1, 0, 0)
	elseif playdate.buttonJustPressed("b") then
		rects.createParticle(math.random(0, 400), math.random(0, 240), 1, 0, 0)
	end
end

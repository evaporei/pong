local Ball = {}

BALL_SIDE = 4

local startPos = function (pos)
    return pos - (BALL_SIDE / 2)
end

local genVX = function ()
    return math.random(2) == 1 and 100 or -100
end

local genVY = function ()
    return math.random(-50, 50)
end

function Ball.new(startX, startY)
    local b = {
        startX = startX,
        startY = startY,
        x = startPos(startX),
        y = startPos(startY),
        vx = genVX(),
        vy = genVY()
    }
    setmetatable(b, { __index = Ball })
    return b
end

function Ball:update(dt)
    self.x = self.x + self.vx * dt
    self.y = self.y + self.vy * dt
end

function Ball:reset()
    self.x = startPos(self.startX)
    self.y = startPos(self.startY)

    self.vx = genVX()
    self.vy = genVY()
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, BALL_SIDE, BALL_SIDE)
end

return Ball

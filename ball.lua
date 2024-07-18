local Ball = {}

BALL_SIDE = 4

local function startPos(pos)
    return pos - (BALL_SIDE / 2)
end

local function genVX()
    return math.random(2) == 1 and 100 or -100
end

local function genVY()
    return math.random(-50, 50)
end

function Ball.new(startX, startY)
    local b = {
        startX = startX,
        startY = startY,
        width = BALL_SIDE,
        height = BALL_SIDE,
        x = startPos(startX),
        y = startPos(startY),
        vx = genVX(),
        vy = genVY()
    }
    setmetatable(b, { __index = Ball })
    return b
end

function Ball:collides(paddle)
    if self.x > paddle.x + paddle.width or paddle.x > self.x + self.width then
        return false
    end

    if self.y > paddle.y + paddle.height or paddle.y > self.y + self.height then
        return false
    end

    return true
end

-- shift direction
function Ball:bouncePaddle(paddle, dir)
    -- shift dir/velocity with noise
    self.vx = -self.vx * 1.03
    -- we're inside paddle, let's get out
    if dir == 'right' then
        self.x = paddle.x + paddle.width
    elseif dir == 'left' then
        self.x = paddle.x - paddle.width
    end

    -- keep velocity going in the same direction, but randomize it
    if self.vy < 0 then
        self.vy = -math.random(10, 150)
    else
        self.vy = math.random(10, 150)
    end
end

function Ball:serve(dir)
    self.vy = genVY()
    if dir == 'right' then
        self.vx = math.random(140, 200)
    elseif dir == 'left' then
        self.vx = -math.random(140, 200)
    end
end

function Ball:bounceWall(GAME_HEIGHT)
    if self.y <= 0 then
        self.y = 0
        self.vy = -self.vy
    end

    if self.y >= GAME_HEIGHT - self.height then
        self.y = GAME_HEIGHT - self.height
        self.vy = -self.vy
    end
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

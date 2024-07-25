local Ball = {}

local function randVX()
    return math.random(2) == 1 and 100 or -100
end

local function randVY()
    return math.random(-50, 50)
end

function Ball.new(gameWidth, gameHeight)
    local self = {}

    self.width = 4
    self.height = 4

    self.startX = gameWidth / 2 - (self.width / 2)
    self.startY = gameHeight / 2 - (self.height / 2)

    self.x, self.y = self.startX, self.startY

    self.vx = randVX()
    self.vy = randVY()

    setmetatable(self, { __index = Ball })
    return self
end

function Ball:collides(paddle)
    if self.x > paddle.x + paddle.width or self.x + self.width < paddle.x then
        return false
    end
    if self.y > paddle.y + paddle.height or self.y + self.height < paddle.y then
        return false
    end
    return true
end

function Ball:bouncePaddle(paddle, dir)
    -- change x dir, randomize it a bit
    self.vx = -self.vx * 1.03

    -- we're inside of the paddle, let's get out
    if dir == 'right' then
        self.x = paddle.x + paddle.width
    elseif dir == 'left' then
        self.x = paddle.x - paddle.width
    end

    -- keep the same y dir, but randomize speed
    if self.vy < 0 then
        self.vy = -math.random(10, 150)
    else
        self.vy = math.random(10, 150)
    end
end

function Ball:bounceWall(gameHeight)
    if self.y + self.height > gameHeight then
        self.y = gameHeight - self.height
        self.vy = -self.vy
        return true
    end

    if self.y < 0 then
        self.y = 0
        self.vy = -self.vy
        return true
    end

    return false
end

function Ball:isOutOfGame(gameWidth)
    if self.x < 0 then
        return 'left'
    end
    if self.x + self.width > gameWidth then
        return 'right'
    end
    return nil
end

function Ball:update(dt)
    self.x = self.x + self.vx * dt
    self.y = self.y + self.vy * dt
end

function Ball:reset()
    self.x, self.y = self.startX, self.startY

    self.vx = randVX()
    self.vy = randVY()
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

return Ball

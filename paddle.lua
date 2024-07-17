local Paddle = {}

PADDLE_WIDTH = 5
PADDLE_HEIGHT = 20

PADDLE_SPEED = 200

function Paddle.new(startX, startY, gameHeight)
    local p = {
        gameHeight = gameHeight,
        x = startX,
        y = startY,
        vy = 0
    }
    setmetatable(p, { __index = Paddle })
    return p
end

function Paddle:up()
    self.vy = -PADDLE_SPEED
end

function Paddle:down()
    self.vy = PADDLE_SPEED
end

function Paddle:resetVelocity()
    self.vy = 0
end

function Paddle:update(dt)
    if self.vy < 0 then
        -- up
        self.y = math.max(0, self.y + self.vy * dt)
    else
        -- down
        self.y = math.min(self.gameHeight - PADDLE_HEIGHT, self.y + self.vy * dt)
    end
end

function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, PADDLE_WIDTH, PADDLE_HEIGHT)
end

return Paddle

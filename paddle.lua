local Paddle = {}

local SPEED = 200

function Paddle.new(startX, startY)
    local self = {}

    self.startX, self.startY = startX, startY

    self.x, self.y = self.startX, self.startY

    self.width = 5
    self.height = 20

    self.vy = 0

    setmetatable(self, { __index = Paddle })
    return self
end

-- pass a keys table like this:
-- { up = 'w', down = 's' }
-- or
-- { up = 'up', down = 'down' }
function Paddle:setInput(keys)
    self.keys = keys
end

function Paddle:handleInput()
    if love.keyboard.isDown(self.keys.up) then
        self.vy = -SPEED
    elseif love.keyboard.isDown(self.keys.down) then
        self.vy = SPEED
    else
        self.vy = 0
    end
end

function Paddle:update(dt, gameHeight)
    if self.vy < 0 then
        -- going up
        self.y = math.max(0, self.y + self.vy * dt)
    else
        -- going down
        self.y = math.min(gameHeight - self.height, self.y + self.vy * dt)
    end
end

function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

return Paddle

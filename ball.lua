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

    self.x = gameWidth / 2 - (self.width / 2)
    self.y = gameHeight / 2 - (self.height / 2)

    self.vx = randVX()
    self.vy = randVY()

    setmetatable(self, { __index = Ball })
    return self
end

function Ball:update(dt)
    self.x = self.x + self.vx * dt
    self.y = self.y + self.vy * dt
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

return Ball

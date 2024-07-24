local Ball = {}

function Ball.new(gameWidth, gameHeight)
    local self = {}

    self.width = 4
    self.height = 4

    self.x = gameWidth / 2 - (self.width / 2)
    self.y = gameHeight / 2 - (self.height / 2)

    setmetatable(self, { __index = Ball })
    return self
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

return Ball

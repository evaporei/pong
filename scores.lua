local Scores = {}

function Scores.new(font)
    local self = {}

    self.font = font

    self.player1 = 0
    self.player2 = 0

    setmetatable(self, { __index = Scores })
    return self
end

function Scores:render(gameWidth, gameHeight)
    love.graphics.setFont(self.font)
    love.graphics.print(
        tostring(self.player1),
        gameWidth / 2 - 50,
        gameHeight / 4
    )
    love.graphics.print(
        tostring(self.player2),
        gameWidth / 2 + 30,
        gameHeight / 4
    )
end

return Scores

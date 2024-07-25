local Scores = {}

function Scores.new(font)
    local self = {}

    self.font = font

    self.player1 = 0
    self.player2 = 0

    setmetatable(self, { __index = Scores })
    return self
end

function Scores:increment(dirOut)
    if dirOut == 'left' then
        self.player2 = self.player2 + 1
        return 2, self.player2
    elseif dirOut == 'right' then
        self.player1 = self.player1 + 1
        return 1, self.player1
    end
    -- unreachable
end

function Scores:reset()
    self.player1 = 0
    self.player2 = 0
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

local Game = require('game')

local game = Game.new()

function love.load()
    game:setup()
end

function love.resize(w, h)
    game:resize(w, h)
end

function love.keypressed(key)
    game:handleKeyPressed(key)
end

function love.update(dt)
    game:update(dt)
end

function love.draw()
    game:render()
end

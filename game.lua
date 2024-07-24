local push = require('push')

local Fonts = require('fonts')
local Paddle = require('paddle')

local Game = {}

function Game.new()
    local self = {}

    self.width = 432
    self.height = 243

    setmetatable(self, { __index = Game })
    return self
end

function Game:setup()
    love.window.setTitle('Pong')

    love.graphics.setDefaultFilter('nearest', 'nearest')

    self.fonts = Fonts.new()

    math.randomseed(os.time())

    self.player1 = Paddle.new(5, 30)
    self.player2 = Paddle.new(self.width - 10, self.height - 50)

    -- d instead of w because I use workman layout
    self.player1:setInput({ up = 'd', down = 's' })
    self.player2:setInput({ up = 'up', down = 'down' })

    push:setupScreen(self.width, self.height, 1280, 720, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })
end

function Game:resize(w, h)
    push:resize(w, h)
end

function Game:handleKeyPressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function Game:update(dt)
    self.player1:handleInput()
    self.player2:handleInput()

    self.player1:update(dt, self.height)
    self.player2:update(dt, self.height)
end

function Game:render()
    push:start()

    -- background color
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    self.player1:render()
    self.player2:render()

    push:finish()
end

return Game

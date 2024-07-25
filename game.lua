local push = require('push')

local Fonts = require('fonts')
local Paddle = require('paddle')
local Ball = require('ball')
local Scores = require('scores')
local Sounds = require('sounds')

local Game = {}

function Game.new()
    local self = {}

    self.width = 432
    self.height = 243

    self.state = 'start'

    setmetatable(self, { __index = Game })
    return self
end

function Game:setup()
    love.window.setTitle('Pong')

    love.graphics.setDefaultFilter('nearest', 'nearest')

    self.fonts = Fonts.new()
    self.sounds = Sounds.new()

    math.randomseed(os.time())

    self.player1 = Paddle.new(5, 30)
    self.player2 = Paddle.new(self.width - 10, self.height - 50)

    self.ball = Ball.new(self.width, self.height)

    self.scores = Scores.new(self.fonts.score)

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
    elseif key == 'enter' or key == 'return' then
        if self.state == 'start' then
            self.state = 'play'
        else
            self.state = 'start'

            self.ball:reset()
        end
    end
end

function Game:handleCollisions()
    if self.ball:collides(self.player1) then
        self.ball:bouncePaddle(self.player1, 'right')
        self.sounds['paddle_hit']:play()
    end
    if self.ball:collides(self.player2) then
        self.ball:bouncePaddle(self.player2, 'left')
        self.sounds['paddle_hit']:play()
    end
    if self.ball:bounceWall(self.height) then
        self.sounds['wall_hit']:play()
    end
end

function Game:update(dt)
    if self.state == 'play' then
        self:handleCollisions()
    end

    self.player1:handleInput()
    self.player2:handleInput()

    self.player1:update(dt, self.height)
    self.player2:update(dt, self.height)

    if self.state == 'play' then
        self.ball:update(dt)
    end
end

function Game:render()
    push:start()

    -- background color
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    if self.state == 'start' then
        love.graphics.setFont(self.fonts.small)
        love.graphics.printf(
            "Press 'Enter' to play!",
            0,
            self.height / 8,
            self.width,
            'center'
        )
    elseif self.state == 'play' then
        -- nothing for now
    end

    self.scores:render(self.width, self.height)

    self.player1:render()
    self.player2:render()

    self.ball:render()

    push:finish()
end

return Game

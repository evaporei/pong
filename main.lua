local push = require('push')

local Paddle = require('paddle')
local Ball = require('ball')

-- virtual
GAME_WIDTH = 432
GAME_HEIGHT = 243

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

local smallFont = love.graphics.newFont('font.ttf', 8)
local scoreFont = love.graphics.newFont('font.ttf', 32)

local player1Score = 0
local player2Score = 0

-- first paddle (left side)
local player1 = Paddle.new(5, 30, GAME_HEIGHT)
-- second paddle (right side)
local player2 = Paddle.new(GAME_WIDTH - 10, GAME_HEIGHT - 50, GAME_HEIGHT)

local ball = Ball.new(GAME_WIDTH / 2, GAME_HEIGHT / 2)

local gameState = 'start'

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Pong')

    math.randomseed(os.time())

    love.graphics.setFont(smallFont)

    push:setupScreen(GAME_WIDTH, GAME_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

function love.update(dt)
    -- sorry I use workman layout
    -- this is WASD
    if love.keyboard.isDown('d') then
        player1:up()
    elseif love.keyboard.isDown('s') then
        player1:down()
    else
        player1:resetVelocity()
    end

    if love.keyboard.isDown('up') then
        player2:up()
    elseif love.keyboard.isDown('down') then
        player2:down()
    else
        player2:resetVelocity()
    end

    if gameState == 'play' then
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'

            ball:reset()
        end
    end
end

local function displayFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 255/255, 0, 255/255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()))
end

function love.draw()
    push:apply('start')

    -- reset background to similar color of original pong
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    -- render title
    love.graphics.setFont(smallFont)
    love.graphics.printf(
        'Hello Pong!',
        0,
        20,
        GAME_WIDTH,
        'center'
    )

    -- render score
    love.graphics.setFont(scoreFont)
    love.graphics.print(
        tostring(player1Score),
        GAME_WIDTH / 2 - 50,
        GAME_HEIGHT / 3
    )
    love.graphics.print(
        tostring(player2Score),
        GAME_WIDTH / 2 + 50,
        GAME_HEIGHT / 3
    )

    player1:render()
    player2:render()

    ball:render()

    displayFPS()

    push:apply('end')
end

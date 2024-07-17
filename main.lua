local push = require('push')

-- virtual
GAME_WIDTH = 432
GAME_HEIGHT = 243

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

local smallFont = love.graphics.newFont('font.ttf', 8)
local scoreFont = love.graphics.newFont('font.ttf', 32)

PADDLE_SPEED = 200

local player1Score = 0
local player2Score = 0

local player1Y = 30
local player2Y = GAME_HEIGHT - 50

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

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
        player1Y = player1Y + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown('s') then
        player1Y = player1Y + PADDLE_SPEED * dt
    end

    if love.keyboard.isDown('up') then
        player2Y = player2Y + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown('down') then
        player2Y = player2Y + PADDLE_SPEED * dt
    end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

PADDLE_WIDTH = 5
PADDLE_HEIGHT = 20

BALL_SIDE = 4

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

    -- first paddle (left side)
    love.graphics.rectangle('fill', 5, player1Y, PADDLE_WIDTH, PADDLE_HEIGHT)

    -- second paddle (right side)
    love.graphics.rectangle('fill', GAME_WIDTH - 10, player2Y, PADDLE_WIDTH, PADDLE_HEIGHT)

    -- ball
    love.graphics.rectangle('fill', GAME_WIDTH / 2 - 2, GAME_HEIGHT / 2 - 2, BALL_SIDE, BALL_SIDE)

    push:apply('end')
end

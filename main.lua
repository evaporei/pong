local push = require('push')

local Paddle = require('paddle')
local Ball = require('ball')

-- virtual
GAME_WIDTH = 432
GAME_HEIGHT = 243

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

WINNING_SCORE = 10

local smallFont = love.graphics.newFont('font.ttf', 8)
local largeFont = love.graphics.newFont('font.ttf', 16)
local scoreFont = love.graphics.newFont('font.ttf', 32)

local player1Score = 0
local player2Score = 0

local servingPlayer = 1
local winningPlayer = 0 -- none

-- first paddle (left side)
local player1 = Paddle.new(5, 30, GAME_HEIGHT)
-- second paddle (right side)
local player2 = Paddle.new(GAME_WIDTH - 10, GAME_HEIGHT - 50, GAME_HEIGHT)

local ball = Ball.new(GAME_WIDTH / 2, GAME_HEIGHT / 2)

local gameState = 'start'

local enableFPS = false

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
    if gameState == 'serve' then
        ball:serve(servingPlayer == 1 and "right" or "left")
    elseif gameState == 'play' then
        if ball:collides(player1) then
            ball:bouncePaddle(player1, 'right')
        end
        if ball:collides(player2) then
            ball:bouncePaddle(player2, 'left')
        end

        ball:bounceWall(GAME_HEIGHT)

        -- score
        if ball.x < 0 then
            servingPlayer = 1
            player2Score = player2Score + 1

            if player2Score == WINNING_SCORE then
                winningPlayer = 2
                gameState = 'done'
            else
                gameState = 'serve'
                ball:reset()
            end
        end

        if ball.x > GAME_WIDTH then
            servingPlayer = 2
            player1Score = player1Score + 1

            if player1Score == WINNING_SCORE then
                winningPlayer = 1
                gameState = 'done'
            else
                gameState = 'serve'
                ball:reset()
            end
        end
    end

    -- sorry I use workman layout
    -- this is WASD
    if love.keyboard.isDown('d') then
        player1:up()
    elseif love.keyboard.isDown('s') then
        player1:down()
    else
        player1:stop()
    end

    if love.keyboard.isDown('up') then
        player2:up()
    elseif love.keyboard.isDown('down') then
        player2:down()
    else
        player2:stop()
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
            gameState = 'serve'
        elseif gameState == 'serve' then
            gameState = 'play'
        elseif gameState == 'done' then
            gameState = 'serve'

            ball:reset()

            player1Score = 0
            player2Score = 0

            if winningPlayer == 1 then
                servingPlayer = 2
            else
                servingPlayer = 1
            end
        end
    elseif key == 'f' then
        enableFPS = not enableFPS
    end
end

local function displayFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 255/255, 0, 255/255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()))
end

local function displayScore()
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
end

function love.draw()
    push:apply('start')

    -- reset background to similar color of original pong
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    displayScore()

    -- render title
    if gameState == 'start' then
        love.graphics.setFont(smallFont)
        love.graphics.printf(
            'Welcome to Pong!',
            0,
            10,
            GAME_WIDTH,
            'center'
        )
        love.graphics.printf(
            'Press Enter to begin!',
            0,
            20,
            GAME_WIDTH,
            'center'
        )
    elseif gameState == 'serve' then
        love.graphics.setFont(smallFont)
        love.graphics.printf(
            'Player ' .. tostring(servingPlayer) .. "'s serve!",
            0,
            10,
            GAME_WIDTH,
            'center'
        )
        love.graphics.printf(
            'Press Enter to serve!',
            0,
            20,
            GAME_WIDTH,
            'center'
        )
    elseif gameState == 'play' then
        -- nothing
    elseif gameState == 'done' then
        love.graphics.setFont(largeFont)
        love.graphics.printf(
            'Player ' .. tostring(winningPlayer) .. "wins!",
            0,
            10,
            GAME_WIDTH,
            'center'
        )
        love.graphics.setFont(smallFont)
        love.graphics.printf(
            'Press Enter to restart!',
            0,
            30,
            GAME_WIDTH,
            'center'
        )
    end

    player1:render()
    player2:render()

    ball:render()

    if enableFPS then
        displayFPS()
    end

    push:apply('end')
end

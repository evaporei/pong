local push = require('push')

-- virtual
GAME_WIDTH = 432
GAME_HEIGHT = 243

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    local smallFont = love.graphics.newFont('font.ttf', 8)

    love.graphics.setFont(smallFont)

    push:setupScreen(GAME_WIDTH, GAME_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
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

    love.graphics.printf(
        'Hello Pong!',
        0,
        20,
        GAME_WIDTH,
        'center'
    )

    -- first paddle (left side)
    love.graphics.rectangle('fill', 5, 30, PADDLE_WIDTH, PADDLE_HEIGHT)

    -- second paddle (right side)
    love.graphics.rectangle('fill', GAME_WIDTH - 10, GAME_HEIGHT - 50, PADDLE_WIDTH, PADDLE_HEIGHT)

    -- ball
    love.graphics.rectangle('fill', GAME_WIDTH / 2 - 2, GAME_HEIGHT / 2 - 2, BALL_SIDE, BALL_SIDE)

    push:apply('end')
end

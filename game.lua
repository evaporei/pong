local push = require('push')

local Fonts = require('fonts')

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

function Game:render()
    push:start()

    -- background color
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    push:finish()
end

return Game

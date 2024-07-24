FONT_FILE = 'font.ttf'

local Fonts = {}

-- function because we need to create fonts
-- after love.graphics.setDefaultFilter is called
function Fonts.new()
    return {
        small = love.graphics.newFont(FONT_FILE, 8),
        large = love.graphics.newFont(FONT_FILE, 16),
        score = love.graphics.newFont(FONT_FILE, 32)
    }
end

return Fonts

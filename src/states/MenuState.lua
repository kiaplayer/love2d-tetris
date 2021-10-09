MenuState = Class{__includes = BaseState}

function MenuState:init()
    -- nothing
end

function MenuState:update()
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        initNewGame()
        gStateMachine:change('play')
    end
end

function MenuState:render()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(gDefaultFont)
    love.graphics.printf('TETRIS', 0, 20, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gSmallFont)
    love.graphics.printf('Press Enter to play', 0, 40, VIRTUAL_WIDTH, 'center')
end
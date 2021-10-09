PauseState = Class{__includes = BaseState}

function PauseState:init()
    -- nothing
end

function PauseState:update()
    if love.keyboard.wasPressed('p') then
        gStateMachine:change('play')
    end
end

function PauseState:render()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(gDefaultFont)
    love.graphics.printf('Paused', 0, 20, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gSmallFont)
    love.graphics.printf('Press P to continue', 0, 40, VIRTUAL_WIDTH, 'center')
end
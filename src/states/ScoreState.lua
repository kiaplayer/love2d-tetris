ScoreState = Class{__includes = BaseState}

function ScoreState:init()
    -- nothing
end

function ScoreState:update()
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('menu')
    end
end

function ScoreState:render()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(gDefaultFont)
    love.graphics.printf('Score state', 0, 20, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gSmallFont)
    love.graphics.printf('Your score: ' .. gScore, 0, 40, VIRTUAL_WIDTH, 'center')
end
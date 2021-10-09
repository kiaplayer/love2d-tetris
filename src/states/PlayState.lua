PlayState = Class{__includes = BaseState}

function PlayState:init()
    -- nothing
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('p') then
        gStateMachine:change('pause')
    end
    gMap:update(dt)
    gCurrentFigure:update(dt)
    gNextMap:update(dt)
end

function PlayState:render()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(gDefaultFont)
    love.graphics.printf('Score: ' .. tostring(gScore), 0, 20, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gSmallFont)
    love.graphics.printf('Next', 265, 26, 25, 'center')
    gMap:render()
    gCurrentFigure:render()
    gNextMap:render()
    gNextFigure:render()
end
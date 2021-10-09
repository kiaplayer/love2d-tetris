require 'src/Dependencies'

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Tetris')
    math.randomseed(os.time())
    gDefaultFont = love.graphics.newFont('fonts/font.ttf', 16)
    gSmallFont = love.graphics.newFont('fonts/font.ttf', 8)
    love.graphics.setFont(gDefaultFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true,
        canvas = false
    })

    gStateMachine = StateMachine {
        ['menu'] = function() return MenuState() end,
        ['play'] = function() return PlayState() end,
        ['pause'] = function() return PauseState() end,
        ['score'] = function() return ScoreState() end,
    }
    gStateMachine:change('menu')

    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}
end

function initNewGame()

    gMap = Map(
        MAP_WIDTH_IN_CELLS,
        MAP_HEIGHT_IN_CELLS,
        MAP_CELL_SIZE,
        MAP_OFFSET_X,
        MAP_OFFSET_Y,
        MAP_BACKGROUND_COLOR,
        {}
    )

    gNextMap = Map(
        NEXT_MAP_WIDTH_IN_CELLS,
        NEXT_MAP_HEIGHT_IN_CELLS,
        NEXT_MAP_CELL_SIZE,
        NEXT_MAP_OFFSET_X,
        NEXT_MAP_OFFSET_Y,
        NEXT_MAP_BACKGROUND_COLOR,
        {}
    )

    gScore = 0

    gCurrentFigure = addFigureToMap(
        gMap,
        getRandomColor(),
        array.random(FIGURES),
        math.random(0, 1) and -1 or 1,
        math.random(0, 3) * math.pi/2,
        GAME_SPEED
    )

    gNextFigure = addFigureToMap(
        gNextMap,
        getRandomColor(),
        array.random(FIGURES),
        math.random(0, 1) and -1 or 1,
        math.random(0, 3) * math.pi/2,
        GAME_SPEED
    )

end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
    if key == 'escape' then
        love.event.quit()
    end
end

function love.mousepressed(_, _, button)
    love.mouse.buttonsPressed[button] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.mouse.wasPressed(button)
    return love.mouse.buttonsPressed[button]
end

function love.draw()
    push:start()
    gStateMachine:render()
    push:finish()
end

function love.conf(t)
    t.console = true
end

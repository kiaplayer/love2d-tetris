Figure = Class{}

local timer = 0

function Figure:init(map, bricks, color, figureData, reflectionFactor, angle, speed)
    self.map = map
    self.bricks = bricks
    self.color = color
    self.figureData = figureData
    self.reflectionFactor = reflectionFactor
    self.angle = angle
    self.speed = speed
    self.moving_direction = DIRECTION_NONE;
    self.moving_timer = 0;
end

function Figure:update(dt)

    if love.keyboard.wasPressed('down') or love.keyboard.wasPressed('s') then
        self.speed = 1 / dt
    end

    if love.keyboard.wasPressed('space') or love.mouse.wasPressed(1) and rotatePosition then
        local rotatePosition = false
        for _, brick in pairs(self.bricks) do
            if brick.isRotateCenter then
                rotatePosition = {brick.x, brick.y}
                break
            end
        end
        local trans = love.math.newTransform(rotatePosition[1], rotatePosition[2], math.pi/2)
        local canRotate = true
        for _, brick in pairs(self.bricks) do
            local newX, newY = trans:transformPoint(brick.x - rotatePosition[1], brick.y - rotatePosition[2])
            newX = roundValue(newX)
            newY = roundValue(newY)
            if newX < 1 or newX > self.map.width or newY < 1 then
                canRotate = false
                break
            end
        end
        if canRotate then
            for _, brick in pairs(self.bricks) do
                local newX, newY = trans:transformPoint(brick.x - rotatePosition[1], brick.y - rotatePosition[2])
                brick.x = roundValue(newX)
                brick.y = roundValue(newY)
            end
        end
    end

    local dx = 0
    local dy = 0

    local minX = self.map.width
    local maxX = 1
    for _, brick in pairs(self.bricks) do
        minX = math.min(brick.x, minX)
        maxX = math.max(brick.x, maxX)
    end

    if (love.keyboard.wasPressed('left') or love.keyboard.wasPressed('a')) and minX > 1 then
        dx = -1
        self.moving_direction = DIRECTION_LEFT
        self.moving_timer = 0
    elseif (love.keyboard.wasPressed('right') or love.keyboard.wasPressed('d')) and maxX < self.map.width then
        dx = 1
        self.moving_direction = DIRECTION_RIGHT
        self.moving_timer = 0
    end

    if self.moving_direction == DIRECTION_LEFT and not (love.keyboard.isDown('left') or love.keyboard.isDown('a')) then
        self.moving_direction = DIRECTION_NONE
    elseif self.moving_direction == DIRECTION_RIGHT and not (love.keyboard.isDown('right') or love.keyboard.isDown('d')) then
        self.moving_direction = DIRECTION_NONE
    end

    if self.moving_direction ~= DIRECTION_NONE then
        self.moving_timer = self.moving_timer + dt
        if self.moving_timer > 1 / (2 * self.speed) then
            dx = self.moving_direction
            self.moving_timer = 0
        end
    end

    timer = timer + dt
    if timer >= 1 / self.speed then
        dy = 1
        timer = 0
    end

    if dx ~= 0 then
        for _, brick in pairs(self.bricks) do
            if not gMap:isEmptyPosition({brick.x + dx, brick.y + dy}) then
                dx = 0
                break
            end
        end
    end

    -- Check figure stop
    local needStop = false
    for _, brick in pairs(self.bricks) do
        brick.x = brick.x + dx
        brick.y = brick.y + dy
        brick:update(dt)
        if not needStop and not gMap:isEmptyPosition({brick.x, brick.y + 1}) then
            needStop = true
        end
    end
    if needStop then
        gMap:addBricks(self.bricks)
        gCurrentFigure = addFigureToMap(
            gMap,
            gNextFigure.color,
            gNextFigure.figureData,
            gNextFigure.reflectionFactor,
            gNextFigure.angle,
            gNextFigure.speed
        )
        gNextFigure = addFigureToMap(
            gNextMap,
            getRandomColor(),
            array.random(FIGURES),
            math.random(0, 1) and -1 or 1,
            math.random(0, 3) * math.pi/2,
            GAME_SPEED
        )

        -- Check game finish condition
        for _, brick in pairs(gCurrentFigure.bricks) do
            if not gMap:isEmptyPosition({brick.x, brick.y}) then
                gStateMachine:change('score')
                break
            end
        end
    end
end

function Figure:render()
    for _, brick in pairs(self.bricks) do
        brick:render()
    end
end

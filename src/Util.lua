function positionToMapPosition(map, position)
    return {
        ((position[1] - map.offsetX) / map.cellSize) + 1,
        ((position[2] - map.offsetY) / map.cellSize) + 1,
    }
end

function mapPositionToPosition(map, mapPosition)
    return {
        (mapPosition[1] - 1) * map.cellSize + map.offsetX,
        (mapPosition[2] - 1) * map.cellSize + map.offsetY,
    }
end

function getRandomColor()
    return array.map(array.random(BRICK_COLORS), function(colorPart) return colorPart / 255 end)
end

function addFigureToMap(map, color, figureData, reflectionFactor, angle, speed)

    -- Generate bricks
    local bricks = {}
    for i, brickData in pairs(figureData) do
        local isRotateCenter = brickData[1] == 0 and brickData[2] == 0
        bricks[i] = Brick(map, brickData[1] + 1, brickData[2] + 1, color, isRotateCenter)
    end

    -- Reflection and rotation
    local trans = love.math.newTransform(0, 0, angle)
    for _, brick in pairs(bricks) do
        local newX, newY = trans:transformPoint(brick.x, brick.y)
        brick.x = reflectionFactor * roundValue(newX)
        brick.y = roundValue(newY)
    end

    -- Add figure to map
    local minX = map.width
    local maxX = 1
    local minY = map.height
    local maxY = 1
    for _, brick in pairs(bricks) do
        minX = math.min(brick.x, minX)
        maxX = math.max(brick.x, maxX)
        minY = math.min(brick.y, minY)
        maxY = math.max(brick.y, maxY)
    end
    local dy = -1 * (minY - 1)
    local dx = math.ceil((map.width - (maxX - minX + 1)) / 2) - minX + 1
    for _, brick in pairs(bricks) do
        brick.x = brick.x + dx
        brick.y = brick.y + dy
    end

    return Figure(map, bricks, color, figureData, reflectionFactor, angle, speed)
end

function roundValue(value)
    return math.floor(value + 0.5)
end

function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

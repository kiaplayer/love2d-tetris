Map = Class{}

function Map:init(width, height, cellSize, offsetX, offsetY, backColor, bricks)
    self.width = width
    self.height = height
    self.cellSize = cellSize
    self.offsetX = offsetX
    self.offsetY = offsetY
    self.backColor = backColor
    self.bricks = {}
    for y = 1, height do
        self.bricks[y] = {}
    end
    for _, brick in pairs(bricks) do
        self.bricks[brick.y][brick.x] = brick;
    end
end

function Map:update(dt)
    for _, bricksByY in pairs(self.bricks) do
        for _, brick in pairs(bricksByY) do
            brick:update(dt)
        end
    end
end

function Map:render()
    love.graphics.setColor(self.backColor[1], self.backColor[2], self.backColor[3])
    love.graphics.rectangle(
        'fill',
        self.offsetX,
        self.offsetY,
        self.width * self.cellSize,
        self.height * self.cellSize
    )
    for _, bricksByY in pairs(self.bricks) do
        for _, brick in pairs(bricksByY) do
            brick:render()
        end
    end
end

function Map:isEmptyPosition(mapPosition)
    if mapPosition[2] > self.height or mapPosition[2] < 1 or
       mapPosition[1] > self.width or mapPosition[1] < 1 then
        return false
    end
    return not self.bricks[mapPosition[2]][mapPosition[1]]
end

function Map:addBricks(bricks)
    for _, brick in pairs(bricks) do
        self.bricks[brick.y][brick.x] = brick;
    end
    self:checkFullRows()
end

function Map:checkFullRows()
    for y, bricksByY in pairs(self.bricks) do
        if tablelength(bricksByY) == self.width then
            self.bricks[y] = {}
            gScore = gScore + self.width
            if y > 1 then
                for upperY = y - 1, 1, -1 do
                    for _, brick in pairs(self.bricks[upperY]) do
                        brick.y = brick.y + 1
                        self.bricks[upperY + 1][brick.x] = brick
                    end
                    self.bricks[upperY] = {}
                end
            end
        end
    end
end
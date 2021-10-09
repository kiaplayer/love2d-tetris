Brick = Class{}

function Brick:init(map, x, y, color, isRotateCenter)
    self.map = map
    self.x = x
    self.y = y
    self.dy = 0
    self.dx = 0
    self.color = color
    self.isRotateCenter = isRotateCenter
end

function Brick:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Brick:render()
    love.graphics.setColor(self.color[1], self.color[2], self.color[3])
    position = mapPositionToPosition(self.map,{self.x, self.y})
    love.graphics.rectangle(
        'fill',
        position[1],
        position[2],
        self.map.cellSize,
        self.map.cellSize
    )
end

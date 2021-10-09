WINDOW_WIDTH = 400
WINDOW_HEIGHT = 600

VIRTUAL_WIDTH = 300
VIRTUAL_HEIGHT = 500

GAME_SPEED = 4

MAP_OFFSET_X = 50
MAP_OFFSET_Y = 40
MAP_CELL_SIZE = 10
MAP_WIDTH_IN_CELLS = 20
MAP_HEIGHT_IN_CELLS = 40
MAP_BACKGROUND_COLOR = {0.9, 0.9, 0.9}

NEXT_MAP_OFFSET_X = 265
NEXT_MAP_OFFSET_Y = 40
NEXT_MAP_CELL_SIZE = 5
NEXT_MAP_WIDTH_IN_CELLS = 5
NEXT_MAP_HEIGHT_IN_CELLS = 5
NEXT_MAP_BACKGROUND_COLOR = {0.9, 0.9, 0.9}

DIRECTION_NONE = 0
DIRECTION_LEFT = -1
DIRECTION_RIGHT = 1

BRICK_COLORS = {
    { 233,  30,  99 },
    { 138,  74, 243 },
    {  33,  50, 243 },
    {  76, 175,  80 },
    { 255, 193,   7 },
}

FIGURES = {
    {{-1, 1}, {0, 1},  {0, 0}, {1, 0}},  -- S
    {{-1, 0}, {0, 0},  {0, 1}, {1, 1}},  -- Z
    {{-1, 0}, {0, 0},  {1, 0}, {0, 1}},  -- T
    {{0, -1}, {0, 0},  {0, 1}, {0, 2}},  -- I
    {{-1, 1}, {0, -1}, {0, 0}, {0, 1}},  -- J
    {{0, 0},  {1, 0},  {1, 1}, {0, 1}},  -- O
}
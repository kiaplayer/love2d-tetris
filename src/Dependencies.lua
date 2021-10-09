-- https://github.com/Ulydev/push
push = require 'lib/push'

-- https://github.com/vrld/hump/blob/master/class.lua
Class = require 'lib/class'

-- https://github.com/EvandroLG/array.lua
array = require 'lib/array'

-- Global constants
require 'src/constants'

-- Utility functions
require 'src/Util'

-- State machine with states
require 'lib/StateMachine'
require 'src/states/BaseState'
require 'src/states/MenuState'
require 'src/states/PlayState'
require 'src/states/PauseState'
require 'src/states/ScoreState'

-- Game objects
require 'src/Brick'
require 'src/Map'
require 'src/Figure'

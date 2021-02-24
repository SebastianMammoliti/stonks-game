
-- Include Class library
Class = require 'class'

-- Include StateMachine library, plus any other defined states
require 'StateMachine'
require 'states/BaseState'
require 'states/DefaultState'
require 'states/GameState'
require 'libs/Camera'
require 'libs/List'
require 'Player'

-- Require Classes

-- Constant Variables
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
math.randomseed(os.time())

-- This is a different example code because touching the default love.run is not necessary (in the no vsync scenario), and mine is a bit more specifically tailored... so this is a bit more minimal.
local tickPeriod = 1/60 -- seconds per tick
local accumulator = 0.0

if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

function love.load()
    -- Initialise Window
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    -- Initialise State Machine
    gStateMachine = StateMachine {
        ['default'] = function() return DefaultState() end,
        ['game'] = function() return GameState() end
        -- ['battle'] = function() return BattleState() end,
        -- ['builder'] = function() return BuilderState() end,
    }
    gStateMachine:change('default') 
    
    -- initialize input table
    love.keyboard.keysPressed = {}
    love.mouse.buttonsReleased = {}
end

function love.draw()
    -- Set color to white
    love.graphics.setColor(255,255,255,1)
    love.graphics.printf('Mouse X = ' .. love.mouse.getCameraX(), 0, 0, 200, "left" )
    love.graphics.printf('Mouse Y = ' .. love.mouse.getCameraY(), 0, 20, 200, "left" )
    love.graphics.setColor(0,1,1,1)
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
    -- Render state machine
    gStateMachine:render()
end

function love.update(dt)
    -- This accumulator forces the logic updates to match the desired FPS. Might break keyboard controls. 
    accumulator = accumulator + dt
    if accumulator >= tickPeriod then
        accumulator = accumulator - tickPeriod

        gStateMachine:update(dt)
        love.keyboard.keysPressed = {}
        love.mouse.buttonsReleased = {}
    end
   
end

function love.keypressed(key)
    -- add to our table of keys pressed this frame
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
        
    end
end

function love.mousereleased(x,y,button)
    print('mousereleased ' .. button)
    -- add to our table of mouse buttons released this frame
    love.mouse.buttonsReleased[button] = true
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.mouse.wasClicked(button)
    if love.mouse.buttonsReleased[button] then
        return true
    else
        return false
    end
end

function love.mouse.getCameraX()
    return love.mouse.getX() * camera.scaleX + camera.x
end

function love.mouse.convertCameraX(x)
    return x * camera.scaleX + camera.x
end

function love.mouse.getCameraY()
    return love.mouse.getY() * camera.scaleY + camera.y
end

function love.mouse.convertCameraY(y)
    return y * camera.scaleY + camera.y
end

GameState = Class{__includes = BaseState}

function GameState:init()   
    camera = Camera()
end
function GameState:enter() end
function GameState:exit() end
function GameState:update(dt) 
    
    
    
    
    
    if love.keyboard.wasPressed('f1') then
        -- If f1 is Pressed, go to DefaultState
        gStateMachine:change('default') 
    end
end
function GameState:render() end
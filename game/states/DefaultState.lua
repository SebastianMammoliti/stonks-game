DefaultState = Class{__includes = BaseState}

function DefaultState:init()     
    player1 = Player(WINDOW_WIDTH/2,  WINDOW_HEIGHT/2, 5)
    camera = Camera()
end
function DefaultState:enter() end
function DefaultState:exit() end
function DefaultState:update(dt) 
    if love.keyboard.wasPressed('f1') then
        -- If f1 is Pressed, go to GameState
        gStateMachine:change('game') 
    end

    player1:update()


end
function DefaultState:render() 
    camera:set()
    player1:render()
    camera:unset()
end
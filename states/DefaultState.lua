
DefaultState = Class{__includes = BaseState}

function DefaultState:init() 
    camera = Camera()
end
function DefaultState:enter() end
function DefaultState:exit() end
function DefaultState:update(dt) end
function DefaultState:render() end
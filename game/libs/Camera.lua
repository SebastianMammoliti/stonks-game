Camera = Class{}

function Camera:init()
    self.x = 0
    self.y = 0
    self.scaleX = 1
    self.scaleY = 1
    self.rotation = 0
    self.dx = 0
    self.dy = 0
end


function Camera:set()
  love.graphics.push()
  love.graphics.rotate(-self.rotation)
  love.graphics.scale(1 / self.scaleX, 1 / self.scaleY)
  love.graphics.translate(-self.x, -self.y)
end

function Camera:unset()
  love.graphics.pop()
end

function Camera:move(dx, dy)
  self.x = self.x + (dx or 0)
  self.y = self.y + (dy or 0)
end

function Camera:rotate(dr)
  self.rotation = self.rotation + dr
end

function Camera:scale(sx, sy)
  sx = sx or 1
  self.scaleX = self.scaleX * sx
  self.scaleY = self.scaleY * (sy or sx)
end

function Camera:setPosition(x, y)
  self.x = x or self.x
  self.y = y or self.y
end

function Camera:setScale(sx, sy)
  self.scaleX = sx or self.scaleX
  self.scaleY = sy or self.scaleY
end

function Camera:update(player1)
     -- Movement
     if player1.moving then
        self.x = player1.x - WINDOW_WIDTH/2 
        self.y = player1.y - WINDOW_HEIGHT/2
    end  
end
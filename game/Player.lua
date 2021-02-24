Player = Class{}

function Player:init(x, y, radius)
    self.x = x
    self.y = y
    self.radius = radius
    self.positionHistory = List.new()
    self.diffHistory = List.new()
    self.tableSize = 1
    self.lineTable = {}
end


function Player:render()
  love.graphics.setColor(1,1,1)
  love.graphics.circle('fill', self.x, self.y, self.radius)
  if self.tableSize > 5 then
    love.graphics.line(self.lineTable)
  end
end

function Player:update(dt)
  diff = math.random(-1000, 1000) / 100; -- Create a random number to move between -1 and 1.

  List.pushright(self.positionHistory, self.y + diff) -- Insert into positionHistory Table
  List.pushright(self.diffHistory, diff) -- Insert into diffHistory Table

  if self.tableSize < 1000 then
    self.tableSize = self.tableSize + 1
  else
    List.popleft(self.positionHistory)
    List.popleft(self.diffHistory)
  end

  self.y = self.positionHistory[self.positionHistory["last"]]

  -- Populate lineTable
  self.lineTable = {}

  if self.tableSize > 5 then
    for i=self.positionHistory["last"] - 1, self.positionHistory["first"], -1
    do
      x1 = self.x - (self.positionHistory["last"] - i)
      y1 = self.positionHistory[i+1]
      x2 = self.x - (self.positionHistory["last"] - i)
      y2 = self.positionHistory[i] 
      table.insert(self.lineTable, x1)
      table.insert(self.lineTable, y1)
      table.insert(self.lineTable, x2)
      table.insert(self.lineTable, y2)
    end
  end

  print('mousereleased ')
end

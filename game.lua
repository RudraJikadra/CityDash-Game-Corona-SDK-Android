-- requires
local physics = require "physics"
physics.start()

local storyboard = require ("storyboard")
local scene = storyboard.newScene()

-- background


function scene:createScene(event)

local screenGroup = self.view
 background = display.newImage("bg.png")
background.x = 240
background.y = 140
screenGroup:insert(background)

city1 = display.newImage("city1.png")
city1.x = 240
city1.y = 228
city1.speed = 1
screenGroup:insert(city1)

city2 = display.newImage("city1.png")
city2.x = 720
city2.y = 228
city2.speed = 1
screenGroup:insert(city2)


city3 = display.newImage("city2.png")
city3.x = 240
city3.y = 270
city3.speed = 2
screenGroup:insert(city3)

city4 = display.newImage("city2.png")
city4.x = 720
city4.y = 270
city4.speed = 2
screenGroup:insert(city4)

ceiling = display.newImage("invisibleTile.png")
ceiling.x = 0
ceiling.y = -30
physics.addBody(ceiling, "static", {density=.1, bounce=0.1, friction=.2})
screenGroup:insert(ceiling)


theFloor = display.newImage("invisibleTile.png")
theFloor.x = 0
theFloor.y = 360
physics.addBody(theFloor, "static", {density=.1, bounce=0.1, friction=.2})
screenGroup:insert(theFloor)

-- jet
jet = display.newImage("redJet.png")
jet.x = 80
jet.y = 0
physics.addBody(jet, "dynamic", {density=.1, bounce=0.1, friction=.2, radius=12})
screenGroup:insert(jet)

-- mine
mine1 = display.newImage("mine.png") 
mine1.x = 500
mine1.y = 80
mine1.speed = math.random(2,6)
mine1.initY = mine1.y
mine1.amp = math.random(20,100)
mine1.angle = math.random(1,360)
physics.addBody(mine1, "static", {density=.1, bounce=0.1, friction=.1, radius=15})
screenGroup:insert(mine1)

mine2 = display.newImage("mine.png") 
mine2.x = 500
mine2.y = 200
mine2.speed = math.random(2,6)
mine2.initY = mine2.y
mine2.amp = math.random(20,100)
mine2.angle = math.random(1,360)
physics.addBody(mine2, "static", {density=.1, bounce=0.1, friction=.1, radius=15})
screenGroup:insert(mine2)

mine3 = display.newImage("mine.png") 
mine3.x = 500
mine3.y = 250
mine3.speed = math.random(2,6)
mine3.initY = mine3.y
mine3.amp = math.random(20,100)
mine3.angle = math.random(1,360)
physics.addBody(mine3, "static", {density=.1, bounce=0.1, friction=.1, radius=15})
screenGroup:insert(mine3)

end


function scrollCity(self,event)
	if self.x < -235 then
	self.x = 720
	else
	 self.x = self.x - self.speed
	end
end

function moveMines(self,event)
  if self.x < -50 then
      self.x = 500
      self.y = math.random(90,550)
      self.speed = math.random(2,5)
      self.amp = math.random(20,100)
      self.angle = math.random(1,360)
	 else
	    self.x = self.x - self.speed
		self.angle = self.angle + .1
		self.y = self.amp * math.sin(self.angle)+self.initY
	end
end	

function activateJets(self,event)
 self:applyForce(0, -1.5, self.x, self.y)
end

function touchScreen(event)
  -- print("touch")
   if event.phase == "began" then 
   -- print("began")
    jet.enterFrame = activateJets
	Runtime:addEventListener("enterFrame", jet)
   end
   
   if event.phase == "ended" then 
  -- print("ended")
  Runtime:removeEventListener("enterFrame", jet)
  
   end
end

function onCollision(event)
  if event.phase == "began" then
    storyboard.gotoScene("restart", "fade", 400)
  end

end

function scene:enterScene(event)



Runtime:addEventListener("touch", touchScreen)

    city1.enterFrame = scrollCity
    Runtime:addEventListener("enterFrame", city1)

    city2.enterFrame = scrollCity
    Runtime:addEventListener("enterFrame", city2)

    city3.enterFrame = scrollCity
    Runtime:addEventListener("enterFrame", city3)

    city4.enterFrame = scrollCity
    Runtime:addEventListener("enterFrame", city4)

mine1.enterFrame = moveMines
Runtime:addEventListener("enterFrame", mine1)

mine2.enterFrame = moveMines
Runtime:addEventListener("enterFrame", mine2)

mine3.enterFrame = moveMines
Runtime:addEventListener("enterFrame", mine3)

Runtime:addEventListener("collision", onCollision)


end

function scene:exitScene(event)
Runtime:removeEventListener("touch", touchScreen)
Runtime:removeEventListener("enterFrame", mine1)
Runtime:removeEventListener("enterFrame", mine2)
Runtime:removeEventListener("enterFrame", mine3)
Runtime:removeEventListener("collision", onCollision)
end

function scene:destroyScene(event)

end



scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)


return scene




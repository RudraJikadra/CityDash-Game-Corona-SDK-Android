-- requires

local storyboard = require ("storyboard")
local scene = storyboard.newScene()

-- background
local RevMob = require("revmob")


function scene:createScene(event)

local screenGroup = self.view

background = display.newImage("restart.png")
background.x = 240
background.y = 245
screenGroup:insert(background)

end


function start(event)
   if event.phase == "began" then
     storyboard.gotoScene("game", "fade", 400)
   end
end

function scene:enterScene(event)
    
 	RevMob.showFullscreen()
	
     storyboard.purgeScene("game")
     --background:addEventListener("touch", start)
	 Runtime:addEventListener("touch", start)
end

function scene:exitScene(event)
  --background:removeEventListener("touch", start)
  Runtime:removeEventListener("touch", start)
end

function scene:destroyScene(event)

end

local AMAZON_APK = false

local REVMOB_IDS = {
 [REVMOB_ID_IOS] = '558ceb81b27eb80e7c0e647d',
 [REVMOB_ID_ANDROID] = '558ceb81b27eb80e7c0e647d',
 
}

if AMAZON_APK then REVMOB_IDS[REVMOB_ID_ANDROID] = '558ceb81b27eb80e7c0e647d' end

   RevMob.startSession(REVMOB_IDS)
  -- RevMob.setTestingMode(RevMob.TEST_WITH_ADS)
 --  RevMob.showFullscreen()

scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)


return scene




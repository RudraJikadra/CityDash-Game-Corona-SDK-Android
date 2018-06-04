display.setStatusBar(display.HiddenStatusBar)

local storyboard = require "storyboard"
local bg_sound = audio.loadStream("bgSound.mp3")


local rj1 = display.newImage("rj1.png", 800, 1200)
rj1.x = 250
rj1.y = 175
transition.fadeOut( rj1, { time=1000, delay=4000, onComplete=storyboard.gotoScene("start") } ) 

audio.play(bg_sound, {loops=-1})

--com.gmail.rhjikadra.city_dash
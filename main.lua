---------------------------------------------------------------------------------
--
-- main.lua
--
---------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- require the composer library
local composer = require "composer"

-- Add any objects that should appear on all scenes below (e.g. tab bar, hud, etc)


-- Add any system wide event handlers, location, key events, system resume/suspend, memory, etc.

-- load scene1
composer.gotoScene( "scene1" )

function onKeyEventPress( event )
    
    if ( event.keyName == "back" and composer.getSceneName( "current" )~= "scene3"  
         and event.phase == "down" ) then
        local platformName = system.getInfo( "platformName" )
        if ( platformName == "Android" ) then
            
            
            
           
            
            composer.gotoScene( "scene3", "fade", 500)
   
            print("back: scene3")
          
            return true
        end
    end

    -- IMPORTANT! Return false to indicate that this app is NOT overriding the received key
    -- This lets the operating system execute its default handling of the key
    return false
end

-- Add the key event listener
Runtime:addEventListener( "key", onKeyEventPress )